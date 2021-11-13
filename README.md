# Bootcamp-App-With-Docker

### Prerequisites:

* **Make sure** all the target machines have docker cli installed and enabled. if not execute the following (one at a time): 

```
sudo apt-get update
sudo apt-get upgrade
sudo apt install docker.io
systemctl start docker
systemctl enable docker
```
* Also **add** the current user to the docker group "docker" to prevent premission errors by executing the following (one at a time): 

```
sudo usermod -aG docker $USER
sudo reboot
```
* For this project I have used a self hosted agent by **following** [This](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/agents?view=azure-devops&tabs=browser) guide. **Make sure** you have an agent up and listening for jobs.

* The target machines should be attached to an environment. **Go** to [Azure Devops](https://dev.azure.com/IdoAlon)  and **Attach** the target machines to
  the required environments. After done correctly, you will notice that when you click on the newly created environment, you can see the list of target 
  machines attached.  

* This pipeline relies on an Azure Container Registry. **Make sure** you have one up and running.

* This project relies on using an Azure Devops Repos. **Make sure** to have your github repository imported to Azure Devops Repos.

## Infrastructure:

<img src="https://bootcamp.rhinops.io/images/docker-envs.png" alt="drawing" width="650"/>

---

## Pipeline Structure:

<img src="https://bootcamp.rhinops.io/images/docker-cicd.png" alt="drawing" width="450"/>

---

## Creating The Pipeline:

#### NOTE: The environment variables for this pipeline are stored in a Variables Group in Azure Devops Libraries. One named staging (will be used in staging), and one named production (will be used in production).

1. **Create** a new pipeline and choose "Azure Repos Git" as your source code.
   * **Select** the required repository.
   * As a pipeline configuration **Choose** "Docker | Build and push an image to Azure Container Registry".
   * **Choose** your active subscription and click "Continue".
   
2. In the yaml pipeline just opened, in the CI stage, **add** a task to build and push the image to the container registry.
3. In the CD to staging, **add** a tasks to:
   * **Stop** and **Delete** the current running container.
   * **Login** to the azure container registry.
   * **Pull** the required image from the azure container registry.
   * Finally, **run** the pulled container by providing this line in your task:    
   ```
   docker run -d --restart=always --name weighttracker -p 8080:8080 -e PGHOST=$(PG_HOST) -e PORT=$(PORT) -e HOST=$(HOST) -e PGUSERNAME=$(PG_USERNAME) -e     PGDATABASE=postgres -e PGPASSWORD=$(PG_PASSWORD) -e PGPORT=$(PG_PORT) -e HOST_URL=$(HOST_URL) -e COOKIE_ENCRYPT_PWD=$(COOKIE_ENCRYPT_PWD) -e NODE_ENV=development -e OKTA_ORG_URL=$(OKTA_ORG_URL) -e OKTA_CLIENT_ID=$(OKTA_CLIENT_ID) -e OKTA_CLIENT_SECRET=$(OKTA_CLIENT_SECRET) $(containerRegistry)/$(imageRepository):$(tag)
   ```
   
4. In the CD to staging, also **Specify** the varaibles group required for this specific stage:
   
   yaml:
   ```
   - stage: DeployToStaging
     variables:
     - group: staging
   ```
5. In the CD to staging **add** a condition for triggering the deployed stages only from master branch:

   yaml:
   ```
   condition: and(succeeded(), eq(variables['build.sourceBranch'], 'refs/heads/master'))
   ```
6. The production stage should be identical to staging stage. The only change is in the variables group:   
      yaml:      
      ```
      - stage: DeployToProduction
        variables:
        - group: production
      ```

## Creating The Branch Policy:

After the CI stage is completed, the deployment to staging stage should be automatic. After the deployment to staging is completed, the deployment
to production should await approval. Moreover, when commiting a change to a feature branch, only the CI stage should be triggered. In order to add 
changes to master branch, create a pull request and after the request is approved, all the CI-CD process will be triggered.

![process](https://user-images.githubusercontent.com/90255849/141645490-00c5a619-c5ef-4b70-858b-1769e7fb079a.png)











# Node.js Weight Tracker

### NOTE:

This is the source code that will be used in Azure Devops regarding Week 9.

[![Build Status](https://dev.azure.com/bootcamp-week-7/Weighttracker/_apis/build/status/Weighttracker-CI?branchName=master)](https://dev.azure.com/bootcamp-week-7/Weighttracker/_build/latest?definitionId=4&branchName=master)

This sample application demonstrates the following technologies.

* [hapi](https://hapi.dev) - a wonderful Node.js application framework
* [PostgreSQL](https://www.postgresql.org/) - a popular relational database
* [Postgres](https://github.com/porsager/postgres) - a new PostgreSQL client for Node.js
* [Vue.js](https://vuejs.org/) - a popular front-end library
* [Bulma](https://bulma.io/) - a great CSS framework based on Flexbox
* [EJS](https://ejs.co/) - a great template library for server-side HTML templates

**Requirements:**

* [Node.js](https://nodejs.org/) 12.x or higher
* [PostgreSQL](https://www.postgresql.org/) (can be installed locally using Docker)
* [Free Okta developer account](https://developer.okta.com/) for account registration, login

## Install and Configuration

1. Clone or download source files
1. Run `npm install` to install dependencies
1. If you don't already have PostgreSQL, set up using Docker
1. Create a [free Okta developer account](https://developer.okta.com/) and add a web application for this app
1. Copy `.env.sample` to `.env` and change the `OKTA_*` values to your application
1. Initialize the PostgreSQL database by running `npm run initdb`
1. Run `npm run dev` to start Node.js

The associated blog post goes into more detail on how to set up PostgreSQL with Docker and how to configure your Okta account.
