import os
from datetime import timedelta

from airflow.decorators import dag, task
from airflow.utils.dates import days_ago
from airflow.providers.snowflake.transfers.copy_into_snowflake import CopyFromExternalStageToSnowflakeOperator

from cosmos import DbtTaskGroup, ProjectConfig, ProfileConfig, ExecutionConfig, RenderConfig
from cosmos.profiles import SnowflakeUserPasswordProfileMapping
from cosmos.constants import SourceRenderingBehavior, TestBehavior

from tasks.scraper import scraper as scraper_module
from tasks import (
    uploader as uploader_module, 
    validator as validator_module)

CSV_PATH = "/tmp/raw_data.csv"

profile_config = ProfileConfig(
    profile_name="default",
    target_name="dev",
    profile_mapping=SnowflakeUserPasswordProfileMapping(
        conn_id="snowflake_conn", 
        profile_args={"database": "DB", "schema": "RECENT"},
    )
)

@dag(
    schedule_interval="@weekly",
    start_date=days_ago(1),  # == yesterday
    default_args={
        'retry_delay': timedelta(minutes=1)
    },
    catchup=False,
)
def main_dag():
    @task(task_id="scrape_data", retries=2)
    def scrape():
        scraper_module.scrape(CSV_PATH)
    
    @task(task_id="validate_scraped_data")
    def validate():
        validator_module.validator(CSV_PATH)

    @task(task_id="upload_to_s3")
    def upload():
        uploader_module.uploader()
    
    move_file_from_s3 = CopyFromExternalStageToSnowflakeOperator(
        task_id='move_file_from_s3',
        snowflake_conn_id='snowflake_conn',
        schema='RECENT',
        table='RAW_TABLE',
        stage='STAGE',
        file_format='CSVFORMAT'
    )

    transform_and_test = DbtTaskGroup(
        group_id='transform_and_test',
        profile_config=profile_config,
        project_config=ProjectConfig(
            dbt_project_path="/usr/local/airflow/dags/dbt",
        ),
        execution_config=ExecutionConfig(
            dbt_executable_path=f"{os.environ['AIRFLOW_HOME']}/dbt_venv/bin/dbt",
        ),
        render_config=RenderConfig(
            source_rendering_behavior=SourceRenderingBehavior.WITH_TESTS_OR_FRESHNESS,
            test_behavior=TestBehavior.AFTER_ALL,
        ),
        operator_args={"install_deps": True},
    )

    scrape() >> validate() >> upload() >> move_file_from_s3 >> transform_and_test

main_dag()