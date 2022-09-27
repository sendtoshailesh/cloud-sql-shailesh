https://blog.pythian.com/how-to-connect-from-cloud-functions-to-the-private-ip-address-of-cloud-sql-in-google-cloud/


https://codelabs.developers.google.com/codelabs/connecting-to-cloud-sql-with-cloud-functions#2

create serverless VPC connector for Private IP based Cloud SQL

https://cloud.google.com/sql/docs/postgres/connect-functions#private-ip_1



cat requirements.txt

cat main.py

in same dir where main.py and requirements.txt exist, run following to deploy the cloud function along with the code:
Make sure to match entry function in main.py in following command:

gcloud beta functions deploy psql_connect --runtime python37 --project shailesh-1 --region asia-south1 --vpc-connector serverless-1 --trigger-http --service-account 664290125703-compute@developer.gserviceaccount.com

Run following to test the function

curl -m 70 -X POST https://asia-south1-shailesh-1.cloudfunctions.net/psql_connect \
-H "Authorization: bearer $(gcloud auth print-identity-token)" \
-H "Content-Type: application/json" \
-d '{}'



admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$ cat requirements.txt
# This file tells Python which modules it needs to import
SQLAlchemy==1.3.12
# If your database is MySQL, uncomment the following line:
#PyMySQL==0.9.3
# If your database is PostgreSQL, uncomment the following line:
pg8000==1.13.2
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$ cat main.py
import pg8000
from sqlalchemy import create_engine
def psql_connect(request):
  engine = create_engine('postgresql+pg8000://postgres:Welcome0@10.45.193.230/postgres',echo=True)
  tab = engine.execute('select tablename from pg_tables;')
  return str([t[0] for t in tab])


admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$



admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$ gcloud beta functions deploy psql_connect --runtime python37 --project shailesh-1 --region asia-south1 --vpc-connector serverless-1 --trigger-http --service-account 664290125703-compute@developer.gserviceaccount.com
Deploying function (may take a while - up to 2 minutes)...⠼
For Cloud Build Logs, visit: https://console.cloud.google.com/cloud-build/builds;region=asia-south1/126aae62-08d9-4362-8be8-3d496381af8e?project=664290125703
Deploying function (may take a while - up to 2 minutes)...done.
availableMemoryMb: 256
buildId: 126aae62-08d9-4362-8be8-3d496381af8e
buildName: projects/664290125703/locations/asia-south1/builds/126aae62-08d9-4362-8be8-3d496381af8e
dockerRegistry: CONTAINER_REGISTRY
entryPoint: psql_connect
httpsTrigger:
  securityLevel: SECURE_OPTIONAL
  url: https://asia-south1-shailesh-1.cloudfunctions.net/psql_connect
ingressSettings: ALLOW_ALL
labels:
  deployment-tool: cli-gcloud
name: projects/shailesh-1/locations/asia-south1/functions/psql_connect
runtime: python37
serviceAccountEmail: 664290125703-compute@developer.gserviceaccount.com
sourceUploadUrl: https://storage.googleapis.com/uploads-515691363631.asia-south1.cloudfunctions.appspot.com/cea632ca-1757-47ef-a829-db4e275952a0.zip
status: ACTIVE
timeout: 60s
updateTime: '2022-09-27T14:20:24.047Z'
versionId: '5'
vpcConnector: serverless-1
vpcConnectorEgressSettings: PRIVATE_RANGES_ONLY
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$



admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$ curl -m 70 -X POST https://asia-south1-shailesh-1.cloudfunctions.net/psql_connect \
> -H "Authorization: bearer $(gcloud auth print-identity-token)" \
> -H "Content-Type: application/json" \
> -d '{}'
['pg_statistic', 'pg_type', 'pg_policy', 'pg_authid', 'pg_user_mapping', 'pg_subscription', 'pg_attribute', 'pg_proc', 'pg_class', 'pg_attrdef', 'pg_constraint', 'pg_inherits', 'pg_index', 'pg_operator', 'pg_opfamily', 'pg_opclass', 'pg_am', 'pg_amop', 'pg_amproc', 'pg_language', 'pg_largeobject_metadata', 'pg_aggregate', 'pg_statistic_ext', 'pg_rewrite', 'pg_trigger', 'pg_event_trigger', 'pg_description', 'pg_cast', 'pg_enum', 'pg_namespace', 'pg_conversion', 'pg_depend', 'pg_database', 'pg_db_role_setting', 'pg_tablespace', 'pg_pltemplate', 'pg_auth_members', 'pg_shdepend', 'pg_shdescription', 'pg_ts_config', 'pg_ts_config_map', 'pg_ts_dict', 'pg_ts_parser', 'pg_ts_template', 'pg_extension', 'pg_foreign_data_wrapper', 'pg_foreign_server', 'pg_foreign_table', 'pg_replication_origin', 'pg_default_acl', 'pg_init_privs', 'pg_seclabel', 'pg_shseclabel', 'pg_collation', 'pg_partitioned_table', 'pg_range', 'pg_transform', 'pg_sequence', 'pg_publication', 'pg_publication_rel', 'pg_subscription_rel', 'pg_largeobject', 'sql_parts', 'sql_languages', 'sql_features', 'sql_implementation_info', 'sql_packages', 'sql_sizing', 'sql_sizing_profiles']admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$


