# dbt poc Project

This project uses dbt (Data Build Tool) to manage and transform data in a structured and modular manner. It is a dbt project for Snowflake databases that includes a set of models, tests, and documentation for transforming and querying data in Snowflake.

## Prerequisites
    - An active [Snowflake](https://signup.snowflake.com/) account;
    - Python3+ installed on your machine

## Getting Started
1. Clone this [repository](https://github.com/joaoheron/dbt_poc).
2. Create a .env file in the root folder of the repository and add the following content:
```
    DBT_USER=youruser
    DBT_PASSWORD=yourpassword
```
3. Update the **project_conf.sh** file with your Snowflake database credentials.
4. Create a virtual environment in the root folder of the repository and activate it:
```bash
    virtualenv -p python venv
    source venv/bin/activate
```
5. Run the following command to set up the environment:
```bash
    source project_config.sh
```
6. Run the following command to install the project dependencies:
```bash
    dbt deps
```
7. Make sure your Snowflake account has access to the databases "raw" and "dbt_poc". If they don't exist, please create them.
8. Now, we suppose to set up the raw database for dbt processing. dbt do NOT recommend we use the seed command to load large files. To follow best practices, we should use other tool than dbt to load large files into the database. However, to facilitate the configuration and usage of this dbt POC project, we will use dbt seed command to set up the initial raw database.
Open the file **dbt_project.yml** and add another item to the array referred to the seed-paths. You should add the string **"raw"**. The seed-paths should look like the following:
**seed-paths: ["seeds", "raw"]**


```bash
    dbt seed
```
9. Run the following command to execute dbt project transformations:
```bash
    dbt run
```

## Structure
This project is structured in the following way:
    - models: contains all the dbt models defined in the project;
    - seeds: contains the data used to populate some tables in the data warehouse;
    - raw: stores the raw data used to populate the source database;
    - tests: includes tests for the models;
    - macros: contains code snippets in the form of macros that can be reused;

### Models
#### Staging
- /staging/application
1. stg_application__customers.sql : Selects relevant data from the source table app_customers, renaming columns and converting data types.
2. stg_application__employees.sql : Selects relevant data from the source table app_employees, renaming columns and converting data types.
3. stg_application__products.sql : Selects relevant data from the source table app_products, renaming columns and converting data types.
4. stg_application__sales.sql : Selects relevant data from the source table app_sales, renaming columns and converting data types.

- /staging/facebook
1. stg_facebook__customers.sql : Selects relevant data from the source table fb_customers, renaming columns and converting data types.
2. stg_facebook__followers.sql : Selects relevant data from the source table fb_followers, renaming columns and converting data types.
3. stg_facebook__mentions.sql : Selects relevant data from the source table fb_mentions, renaming columns and converting data types.
4. stg_facebook__products.sql : Selects relevant data from the source table fb_products, renaming columns and converting data types.
5. stg_facebook__reviews.sql : Selects relevant data from the source table fb_reviews, renaming columns and converting data types.
6. stg_facebook__sales.sql : Selects relevant data from the source table fb_reviews, renaming columns and converting data types.

#### Intermediate
- /intermediate
1. fb_sales_items.sql : This intermediate model selects data from the stg_facebook__sales staging table and then expands the products_guids and products_quantities, increasing the number of rows by one row for each product sold.

#### Marts
- /marts
1. dim_customers.sql : Selects data from the stg_application__customers and stg_facebook__customers staging tables, joining customers who are registered on both the application source table and the facebook source table.
2. dim_employees.sql : Selects data from the stg_facebook__employees staging table.
3. dim_products.sql :  Selects data from the stg_application__products and stg_facebook__products staging tables, joining products that are registered on both the application source table and the facebook source table.
4. application_facebook_sales.sql : Selects data from the stg_application__sales and stg_facebook__sales staging tables and unions the result. Then, it creates a consistent naming pattern for the columns and gathers the foreign keys to the dimension tables.


## Resources
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
