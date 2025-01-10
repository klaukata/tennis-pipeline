import os
from datetime import datetime

from airflow.decorators import dag, task
from airflow.operators.empty import EmptyOperator
from airflow.providers.snowflake.transfers.copy_into_snowflake import CopyFromExternalStageToSnowflakeOperator

from cosmos import DbtTaskGroup, ProjectConfig, ProfileConfig, ExecutionConfig, RenderConfig
from cosmos.profiles import SnowflakeUserPasswordProfileMapping
from cosmos.constants import SourceRenderingBehavior, TestBehavior

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
    template_searchpath="/usr/local/airflow/include",
    start_date=datetime(2024, 12, 23), #TODO
    catchup=False,
)
def main_dag():
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

    move_file_from_s3 >> transform_and_test

main_dag()