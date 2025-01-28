##  Ultimate Tennis Statistics End-To-End ELT Pipeline

Pipeline that extracts data from [Ultimate Tennis Statistics](https://www.ultimatetennisstatistics.com/) Player database and transforms it for a Power BI Dashboard.

### Overview

### Data Visualization


### Architecture

![img](imgs/Tennis_Pipeline.drawio.png)

Infrastructure provisioning through Terraform, containerized through Docker and orchestrated through Airflow. Created dashboard through Power BI.

### Prerequisites

- [AWS CLI](https://aws.amazon.com/cli/)
- [Snowflake CLI](https://docs.snowflake.com/en/developer-guide/snowflake-cli/installation/installation)
- [Astro CLI](https://www.astronomer.io/docs/astro/cli/install-cli/), required for DBT Core and Airflow integration
- [Terraform](https://www.terraform.io/), required to provision AWS and some of the Snowflake services
- [Docker](https://www.docker.com/), required to run the pipeline in Airflow
- Installed packages from `/requirements.txt`

### How to Run This Project

1. Run `make aws` (enter your access keys and region name).
    
2. Initialize the Terraform environment with `make init`.

3. Run `make dotenv` (creates */vars.env* file and configures the Snowflake connection).

4. Execute `export $(cat vars.env | xargs)` (uses the *vars.env* file as environment variables).

5. Run `make profile` (adds a DBT profile with your Snowflake credentials as environment variables).

6. Execute `make sf` (creates the Snowflake infrastructure).

7. Run `make apply` and enter your e-mail address for Cloudwatch alarm (you can leave it empty) (creates AWS infrastructure and Snowflake storage integration).

8. Run `make files` (generates *airflow_settings.yaml* and *docker-compose.override.yml* with confidential values from environment variables).

9. Run `make airflow`.

10. Run *main_dag* inside the Airflow UI.

### Lessons Learned

### Contact

Please feel free to contact me if you have any questions at [Linkedin](https://www.linkedin.com/in/kkborowy/) or email me at [kkborowy@gmail.com](mailto:kkborowy@gmail.com)! c: