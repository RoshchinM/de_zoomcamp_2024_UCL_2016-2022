# de_zoomcamp_2024_UCL_2016-2022
Final project for DE zoomcamp 2024


# Problem description:

Soccer fans and analysts are often looking for in-depth and relevant insights about Champions League matches to better understand the successes and failures of their favorite teams. However, existing solutions either lack sufficient depth of analysis or do not provide data in a digestible form. As a result, fans and professionals are losing the opportunity to gain a comprehensive insight into the game strategies, player performance and changes in the dynamics of the competition in recent years.

# Project Objective:

To develop a comprehensive dashboard solution that provides users with updated analytical data on the Champions League from 2016-2022. This includes analyzing the performance of teams and players, the dynamics of success in different seasons and comparative analysis of matches. The project aims to increase the accessibility and understanding of complex soccer analytics data for a wide audience.

# Technologies
In this project I mostly used the tools that I learned from Data-Eng-zoomcamp-2024

1) Mage for data orchestration
2) Google Cloud Storage - datalake to store raw dataset in buckets
3) Google BigQuery - data warehouse.
4) Dbt cloud - for developing Analytical Views 
5) Google Compute Engine as the virtual host to host our data pipeline ?
6) Looker - visualization dashboard with main metrics that will helps to find ingsights from data


## Installation and Setup
To set up the project, follow the detailed installation and configuration instructions provided below. The guide will walk you through the necessary steps, including the installation of required dependencies and the configuration of GCP services.

### 1) Clone the repo and move to the repo directory to use the Makefile
```
git clone https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022
```

```
cd de_zoomcamp_2024_UCL_2016-2022
```

### 2) GCP 

In google cloud console - create a new GCP project by clicking New Project button.
![New project](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/1_create_project.png)

Create all resources for project - BigQuery, Cloud Storage and Service Account

[Bucket](https://console.cloud.google.com/storage/browser)
![bucket](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/2_bucket.png)


[IAM](https://console.cloud.google.com/iam-admin)
![service_account](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/3_service_acc.png)

### 3) Mage

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

After pipilines run data will be available in GCP storage
 ![pipeline](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/6_GCP_data.png)

Add triggers to start pipelines with refresh data on monthly basis
 ![pipeline](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/7_triggers.png)

Final active pipiles in Mage 
![pipeline](https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/blob/main/assets/8_mage_pipelines.png

