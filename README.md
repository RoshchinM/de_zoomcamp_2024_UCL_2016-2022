# de_zoomcamp_2024_UCL_2016-2022
Final project for DE zoomcamp 2024


# Problem description:

The UEFA Champions League is a focal point of global football, attracting millions of viewers and generating significant interest from fans, analysts, and sponsors alike. One of the critical aspects for stakeholders is understanding team performance metrics, particularly those relating to stadium attendance and player contributions. Currently, there is a gap in the market for a sophisticated analysis tool that can provide insights into which teams draw the most fans to their home matches and which players are most influential in terms of goals and assists. This gap hinders the ability of sponsors to make informed decisions on where to allocate advertising budgets for maximum exposure and return on investment. Additionally, football clubs and analysts lack precise data to strategize and optimize both team performance and fan engagement.

# Project Objective:

The goal is to create an advanced analytical model and dashboard that provide in-depth insights into the UEFA Champions League statistics, focusing on two main areas: stadium attendance and player performance metrics. The project will leverage existing data on match attendance, goals, and assists to:

1) Identify the football clubs that consistently attract the highest number of fans to their home stadium matches, thereby pinpointing the most lucrative venues for sponsor advertisements.
2) Analyze player performance by quantifying goals and assists to reveal top performers who can potentially be the face of advertising campaigns, enhancing brand visibility and engagement.
By implementing this solution, sponsors can make data-driven decisions on advertising placements, while football clubs and analysts can gain valuable insights into enhancing team performance and fan experience. The project aims to bridge the gap in current sports analytics offerings, providing a comprehensive tool for a range of stakeholders in the football industry.

# Technologies
In this project I mostly used the tools that I learned from Data-Eng-zoomcamp-2024

1) Google Cloud Storage - datalake to store raw dataset in buckets
2) Mage for data orchestration
3) Terraform
4) Google BigQuery - data warehouse.
5) Dbt cloud - for developing Analytical Views 
6) Looker - visualization dashboard with main metrics that will helps to find ingsights from data


## Installation and Setup
To set up the project, follow the detailed installation and configuration instructions provided below. The guide will walk you through the necessary steps, including the installation of required dependencies and the configuration of GCP services.

Clone the repo and move to the repo directory to use the Makefile
```
git clone https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022
```

```
cd de_zoomcamp_2024_UCL_2016-2022
```

### 1) GCP 

In google cloud console - create a new GCP project by clicking New Project button.
![New project](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/1_create_project.png)

Create all resources for project - BigQuery, Cloud Storage and Service Account

[Bucket](https://console.cloud.google.com/storage/browser)
![bucket](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/2_bucket.png)


[IAM](https://console.cloud.google.com/iam-admin)
![service_account](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/3_service_acc.png)

Download JSON with credentials to project folder

### 2) Mage

```
cd mage-orchestration
```

```
docker compose build
```

```
docker compose up
```

Now, navigate to http://localhost:6789 in your browser! You can see Mage

Add GCP credentials location in io_config.yaml 
![gcp](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/5_GCP_cred.png)

Create 6 separate pipelines with Load Transform Export 

![pipeline](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/4_LTE_schema.png)

Mage pipelines code 
[Mage pipelines code](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/mage_pipelines.md)

Add triggers to start pipelines with refresh data on monthly basis
 ![pipeline](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/7_triggers.png)

Final active pipiles in Mage 
![pipeline](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/8_mage_pipelines.png)

### 3) Terraform

1) Download terraform [download page](https://developer.hashicorp.com/terraform/install)
2)  Add the Terraform binary to the system PATH
3) Check version
```
$ terraform version
Terraform v1.7.5
on windows_amd64
```

4) Establish a connection with your cloud service: Set up API credentials or employ a service account key file for verification with your cloud provider.
5) Start a Terraform project: In the command line interface, go to your Terraform project's main directory and execute the command below to initialize the project:

```
terraform init
```
6) Generate and Execute Change Plan: 

Utilize the commands below to formulate an action plan and implement modifications to your infrastructure:

This command crafts an execution blueprint that outlines the prospective changes to your infrastructure. Scrutinize this blueprint to confirm it matches your intentions.

```
terraform plan 
```

Execute this command to put the planned changes into effect. You'll need to endorse the actions by typing 'yes' when prompted to proceed.

```
terraform apply 
```
7) Infrastructure Oversight: 
Leverage Terraform’s suite of commands such as ```plan```, ```apply```, ```destroy```, among others, to control and modify your infrastructure over time. For detailed command specifications and further assistance, consult the Terraform documentation to explore the full array of commands at your disposal.

### 4) Google Cloud Storage/Big query

After pipilines run data will be available in GCP storage
 ![pipeline](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/6_GCP_data.png)

And need to create external tables from this parquets in buckets
 ![ext_tables](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/9_external_table.png)

 From external table create materialized view 

```
CREATE TABLE `UCL.teams_native`
AS
SELECT *
FROM `zoomcamp-ucl-data-mr.UCL.teams_external`;
```
```
CREATE MATERIALIZED VIEW `UCL.teams_materialized`
AS
SELECT *
FROM `UCL.teams_native`;
```
![mat_view](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/10_materialized_view.png)

### 5) DBT cloud

Go to https://www.getdbt.com/ and creates a free account. After creating your account you need to create your project following the instructions:

1. Choose a name in Name your project option.

![dbt_create](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/11_dbt_create.png)

2. In Choose a connection, select BigQuery, add github connection, create dev, prod enviroments

3. Run cloud IDE. Click initialize DBT project 

![dbt_proj](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/12_cloudIDE.png)

4. Plan and execute all transformations 

[Transformations plan](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/dbt_cloud/README.md)

[Transformations models](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/dbt_cloud)

[dbt docs](https://cloud.getdbt.com/accounts/254522/develop/6118890/docs/index.html#!/source_list/staging)
Final dbt schema

![dbt_schema](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/13_dbt_schema.png)
Succesfull dbt run

![dbt_run](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/14_dbt_run.png)
### 6) Looker

Login to  [Looker Studio](https://lookerstudio.google.com/)

Create new report, add data from BigQuery 

 ![Looker](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/15_looker_final.png)

# Summary:
### Stadium Attendance:

The top five clubs with the highest average attendance for home matches with over 10 games played are Tottenham Hotspur, FC Barcelona, Manchester United, Real Madrid, and AS Roma. These clubs demonstrate a strong fan base, indicating lucrative opportunities for sponsors aiming to reach large audiences.
Spain leads the list of countries by average match attendance, followed by England, Portugal, Netherlands, and Germany. This highlights Spain as a potential focal point for sponsors, given the high turnout for matches.
### Player Performance:

Cristiano Ronaldo and Robert Lewandowski are the standout players in terms of goals and assists, suggesting they are influential figures on the pitch with a significant impact on the game's outcome.
When considering goals by nationality, the data visualization indicates a diverse range of players from various countries, showcasing the international appeal of the UEFA Champions League and the opportunity for global marketing strategies.
Implications for Stakeholders:

Sponsors can use this analysis to strategically place their advertisements in stadiums with high attendance figures and select brand ambassadors from among the top-performing players, aligning with the project's objectives to aid in data-driven decision-making.
Football clubs and analysts can leverage these insights to strategize on increasing fan engagement and optimizing team performance, especially focusing on nurturing talents like those of the top scorers and assist providers.

### Conclusion:
The advanced analytical model and dashboard designed for this project effectively address the gap in the market for sophisticated analysis tools. The insights provided enable stakeholders to make informed decisions that can enhance brand visibility, fan experience, and ultimately, the financial success of both sponsors and football clubs within the realm of the UEFA Champions League.

