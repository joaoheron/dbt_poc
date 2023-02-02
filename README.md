# DBT poc Project

This project uses dbt (Data Build Tool) to manage and transform data in a structured and modular way. 
This is a dbt project for Snowflake databases. It includes a set of models, tests, and documentation for transforming and querying data in Snowflake.

## Prerequisites
    - A [Snowflake](https://signup.snowflake.com/) active account;
    - Python3+ installed on your machine

## Getting Started
1. Clone this [repository](https://github.com/joaoheron/dbt_poc)
2. Create a .env file on the root folder of the repository and fill it with the following content:
```
    DBT_USER=youruser
    DBT_PASSWORD=yourpassword
```
3. Update the file project_conf.sh with your Snowflake database credentials;
4. Create a virtual environment on the root folder of the repository and source it:
```bash
    virtualenv -p python venv
    source venv/bin/activate
```
5. Run the following command to set up environment:
```bash
    source project_config.sh
```
6. Run the following command to install project's dependencies:
```bash
    dbt deps
```
7. Make sure your Snowflake account has access to the databases "raw" and "dbt_poc". If they don't exist, please create them.
8. Now, we suppose to set up the raw database for dbt processing. dbt do NOT recommend we use the seed command to load large files. To follow best practices, we should use other tool than dbt to load large files into the database. However, to facilitate the configuration and usage of this dbt POC project, we will use dbt seed command to configure the initial raw database:
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
    - seeds: contains the data used to seed the data warehouse;
    - raw: contains the raw data used to set up the source database;
    - tests: contains tests for the models;
    - macros: contains reusable code in the form of macros;

### Models
#### Staging
- /staging/application
1. stg_application__customers.sql : This model selects desired data from the source table app_customers. It renames columns and converts data types.
2. stg_application__employees.sql : This model selects desired data from the source table app_employees. It renames columns and converts data types.
3. stg_application__products.sql : This model selects desired data from the source table app_products. It renames columns and converts data types.
4. stg_application__sales.sql : This model selects desired data from the source table app_sales. It renames columns and converts data types.

- /staging/facebook
1. stg_facebook__customers.sql : This model selects desired data from the source table fb_customers. It renames columns and converts data types.
2. stg_facebook__followers.sql : This model selects desired data from the source table fb_followers. It renames columns and converts data types.
3. stg_facebook__mentions.sql : This model selects desired data from the source table fb_mentions. It renames columns and converts data types.
4. stg_facebook__products.sql : This model selects desired data from the source table fb_products. It renames columns and converts data types.
5. stg_facebook__reviews.sql : This model selects desired data from the source table fb_reviews. It renames columns and converts data types.
6. stg_facebook__sales.sql : This model selects desired data from the source table fb_reviews. It renames columns and converts data types.

#### Intermediate
- /intermediate
1. fb_sales_items.sql : This intermediate model selects data from the staging table stg_facebook__sales and then flattens the products_guids and products_quantities, increasing the number of rows as one row for each product sold.

#### Marts
- /marts
1. dim_customers.sql : This model selects data from the staging tables stg_application__customers and stg_facebook__customers, joining the customers who are both registered on the application source table and on the facebook source table.
2. dim_employees.sql : This model selects data from the staging table stg_facebook__employees.
3. dim_products.sql :  This model selects data from the staging tables stg_application__products and stg_facebook__products, joining the products which are both registered on the application source table and on the facebook source table.
4. application_facebook_sales.sql : This model selects data from the staging tables stg_application__sales and stg_facebook__sales and unions the result. Then, it creates a naming pattern to the columns and gathers the foreign keys to the dimension tables.


## Resources
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
