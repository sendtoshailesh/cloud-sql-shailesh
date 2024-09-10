https://blog.pythian.com/how-to-connect-from-cloud-functions-to-the-private-ip-address-of-cloud-sql-in-google-cloud/


https://codelabs.developers.google.com/codelabs/connecting-to-cloud-sql-with-cloud-functions#2

create serverless VPC connector for Private IP based Cloud SQL

https://cloud.google.com/sql/docs/postgres/connect-functions#private-ip_1



This sequence of commands demonstrates setting up and deploying a Google Cloud Function that connects to a PostgreSQL database using a private IP address. Let's break it down:

1. `requirements.txt`:
   Contains the required Python libraries:
   - SQLAlchemy (version 1.3.12)
   - pg8000 (version 1.13.2) for PostgreSQL connectivity

2. `main.py`:
   Contains the Cloud Function code:
   ```python
   import pg8000
   from sqlalchemy import create_engine
   def psql_connect(request):
     engine = create_engine('postgresql+pg8000://postgres:Welcome0@10.45.193.230/postgres',echo=True)
     tab = engine.execute('select tablename from pg_tables;')
     return str([t[0] for t in tab])
   ```
   This function connects to a PostgreSQL database at 10.45.193.230 using SQLAlchemy with pg8000 driver, executes a query to list all tables, and returns the result.

3. Deployment command:
   ```
   gcloud beta functions deploy psql_connect --runtime python37 --project shailesh-1 --region asia-south1 --vpc-connector serverless-1 --trigger-http --service-account 664290125703-compute@developer.gserviceaccount.com
   ```
   This deploys the function named 'psql_connect' using Python 3.7 runtime in the asia-south1 region, using a VPC connector named 'serverless-1' to allow private IP access, and sets it up with an HTTP trigger.

4. Test command:
   ```
   curl -m 70 -X POST https://asia-south1-shailesh-1.cloudfunctions.net/psql_connect \
   -H "Authorization: bearer $(gcloud auth print-identity-token)" \
   -H "Content-Type: application/json" \
   -d '{}'
   ```
   This sends a POST request to the deployed function URL, authenticating with a Google Cloud identity token.

5. The response shows a list of PostgreSQL system tables and some custom tables, indicating that the function successfully connected to the database and executed the query.

This setup demonstrates how to connect a Cloud Function to a Cloud SQL PostgreSQL instance using a private IP address. The VPC connector allows the function to access resources on the VPC network, including the privately addressed database, which is more secure than using a public IP.
