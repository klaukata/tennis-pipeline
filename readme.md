# Tennis Statistics End-To-End ELT Pipeline

A weekly scheduled ELT pipeline that scrapes data from [Ultimate Tennis Statistics](https://www.ultimatetennisstatistics.com/) on the top male tennis players of all time, validates it, and uploads it to a S3 data lake. The pipeline then transforms the data in a Snowflake database, preparing it for analysis, machine learning, or other downstream applications.

## Data Visualization

![Power BI Dashboard](imgs/dashboard.png)

## Architecture

![img](imgs/Tennis_Pipeline.drawio.png)

Infrastructure was provisioned using Terraform, containerized with Docker, and orchestrated via Airflow. The Astronomer Cosmos package was utilized to simplify building dbt models and tests as Airflow tasks. A dashboard was created using Power BI.

## Prerequisites

- Unix-like system or [WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
- [AWS CLI](https://aws.amazon.com/cli/)
- [Snowflake CLI](https://docs.snowflake.com/en/developer-guide/snowflake-cli/installation/installation)
- [Astro CLI](https://www.astronomer.io/docs/astro/cli/install-cli/), required for DBT Core and Airflow integration
- [Terraform](https://www.terraform.io/), required to provision AWS and some of the Snowflake services
- [Docker](https://www.docker.com/), required to run the pipeline in Airflow
- Installed packages from `/requirements.txt`

## How to Run This Project 

1. Run `make aws` and enter your AWS access keys and region name.  
2. Initialize the Terraform environment with `make init`.  
3. Execute `make dotenv` to create the *vars.env* file and configure the Snowflake connection.  
4. Load environment variables using `export $(cat vars.env | xargs)`.  
5. Run `make profile` to add a dbt profile with your Snowflake credentials.  
6. Execute `make sf` to create the Snowflake infrastructure.  
7. Run `make apply`, providing your email address for CloudWatch alarm (optional – leave blank to skip). This sets up AWS infrastructure and Snowflake storage integration related resources.  
8. Run `make files` to generate *airflow_settings.yaml* and *docker-compose.override.yml*, incorporating confidential values from environment variables.  
9. Start Airflow with `make airflow`.  
10. Trigger *main_dag* from UI.

## Lessons Learned 

During the development of this ELT project, I gained several valuable insights:  

1.   I learned how to effectively **override Terraform resources** using a remote state. This was essential because the project required creating AWS resources first, followed by Snowflake resources. The Snowflake configurations depended on properties from AWS resources, and the IAM trust policy needed attributes from the integration that was only available after policy creation. Without remote state management, this would have led to a continuous dependency cycle.  

2. **The importance of data validation**. Validating data is a critical step in the data lifecycle. It ensures errors in the dataset are identified early, reducing debugging time and minimizing unnecessary cloud processing costs.

3. **Using Docker Volumes for confidential files**. I discovered that Docker volumes provide a secure way to manage confidential files within containers.

What I Would Do Differently:  

1. **Considering Redshift Instead of Snowflake**. Redshift could have been potentially easier to integrate. With Snowflake, I had to create additional resources such as storage integrations and a stage. However, I opted for Snowflake due to its more generous free trial period.  

2. The method I used for loading environment variables, the `export $(cat vars.env | xargs)` command, posed limitations due to its temporary scope and potential security risks.


## Contact

Please feel free to contact me if you have any questions at [Linkedin](https://www.linkedin.com/in/kkborowy/) or email me at [kkborowy@gmail.com](mailto:kkborowy@gmail.com)! c: