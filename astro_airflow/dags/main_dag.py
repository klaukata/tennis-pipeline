import os
from datetime import datetime

from airflow.decorators import dag
from airflow.operators.empty import EmptyOperator

from cosmos import DbtDag, DbtTaskGroup, ProjectConfig, ProfileConfig, ExecutionConfig, RenderConfig
from cosmos.profiles import SnowflakeUserPasswordProfileMapping
from cosmos.constants import SourceRenderingBehavior

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
    start_date=datetime(2024, 12, 23), #TODO
    catchup=False,
)
def main_dag():
    pre_dbt = EmptyOperator(task_id="pre_dbt")

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
        ),
        operator_args={"install_deps": True},
    )

    pre_dbt >> transform_and_test

main_dag()