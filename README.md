Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test

### pharmaceutical_drug_spending.csv
- Pharmaceutical Drug Spending by countries with indicators such as a share of total health spending, in USD per capita (using economy-wide PPPs) and as a share of GDP. Plus, total spending by each countries in the specific year. Population data comes from DataHub http://datahub.io/core/population since it is regularly updated and includes all country codes.
Source: https://datahub.io/core/pharmaceutical_drug_spending

Field information:
- LOCATION [Country Code]: string 
- TIME [Date in the form of %Y]: integer
- PC_HEALTHXP [% of Health spending]: numberic 
- PC_GDP [% of GDP ]: numeric
- USD_CAP [in USD per capita (using economy-wide PPPs)]: numeric
- FLAG_CODES : string
- TOTAL_SPEND [Total spending in millions] : numeric

### countries_aggregated.csv
- COVID-19 dataset Coronavirus disease 2019 (COVID-19) time series listing confirmed cases, reported deaths and reported recoveries. Data is aggregated by country. Coronavirus disease (COVID-19) is caused by the Severe acute respiratory syndrome Coronavirus 2 (SARS-CoV-2) and has had a worldwide effect. On March 11 2020, the World Health Organization (WHO) declared it a pandemic, pointing to the over 118,000 cases of the Coronavirus illness in over 110 countries and territories around the world at the time.
This dataset is licensed under the Open Data Commons Public Domain and Dedication License.The data comes from a variety public sources and was collated in the first instance via Johns Hopkins University on GitHub.
Source: https://datahub.io/core/covid-19

Field information:
- Date : date (%Y-%m-%d) 
- Country : string  
- Confirmed : integer
- Recovered : integer 
- Deaths : integer 

### patient_impact_and_hospital_capacity_by_facility.csv
- This dataset provides facility-level data for hospital utilization aggregated on a weekly basis (Friday to Thursday). These are derived from reports with facility-level granularity across two main sources: (1) HHS TeleTracking, and (2) reporting provided directly to HHS Protect by state/territorial health departments on behalf of their healthcare facilities.
Source: https://healthdata.gov/Hospital/COVID-19-Reported-Patient-Impact-and-Hospital-Capa/anag-cw7u

### patient_impact_and_hospital_capacity_by_state_timeseries.csv
- This dataset provides state-aggregated data for hospital utilization in a timeseries format dating back to January 1, 2020. These are derived from reports with facility-level granularity across three main sources: (1) HHS TeleTracking, (2) reporting provided directly to HHS Protect by state/territorial health departments on behalf of their healthcare facilities and (3) National Healthcare Safety Network.
Source: https://healthdata.gov/Hospital/COVID-19-Reported-Patient-Impact-and-Hospital-Capa/g62h-syeh


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
