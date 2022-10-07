(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-function-cloud-sql/on-public-ip$
(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-function-cloud-sql/on-public-ip$ cat requirements.txt
# This file tells Python which modules it needs to import
SQLAlchemy==1.3.12
# If your database is MySQL, uncomment the following line:
#PyMySQL==0.9.3
# If your database is PostgreSQL, uncomment the following line:
pg8000==1.13.2
(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-function-cloud-sql/on-public-ip$
(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-function-cloud-sql/on-public-ip$
(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-function-cloud-sql/on-public-ip$ cat main.py
import pg8000
from sqlalchemy import create_engine
def psql_connect_public(request):
  engine = create_engine('postgresql+pg8000://postgres:Welcome0@/postgres?unix_sock=/cloudsql/shailesh-1:asia-south1:pg-db22/.s.PGSQL.5432',echo=True)
  tab = engine.execute('select tablename from pg_tables;')
  return str([t[0] for t in tab])


(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-function-cloud-sql/on-public-ip$




(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-function-cloud-sql/on-public-ip$ vi main.py
(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-function-cloud-sql/on-public-ip$ gcloud beta functions deploy psql_connect_public --runtime python37 --project shailesh-1 --region asia-south1 --trigger-http --service-account 664290125703-compute@developer.gserviceaccount.com
Deploying function (may take a while - up to 2 minutes)...⠼
For Cloud Build Logs, visit: https://console.cloud.google.com/cloud-build/builds;region=asia-south1/e65505c0-f3a0-4e5e-8345-c552c48d0cb1?project=664290125703
Deploying function (may take a while - up to 2 minutes)...done.
availableMemoryMb: 256
buildId: e65505c0-f3a0-4e5e-8345-c552c48d0cb1
buildName: projects/664290125703/locations/asia-south1/builds/e65505c0-f3a0-4e5e-8345-c552c48d0cb1
dockerRegistry: CONTAINER_REGISTRY
entryPoint: psql_connect_public
httpsTrigger:
  securityLevel: SECURE_OPTIONAL
  url: https://asia-south1-shailesh-1.cloudfunctions.net/psql_connect_public
ingressSettings: ALLOW_ALL
labels:
  deployment-tool: cli-gcloud
name: projects/shailesh-1/locations/asia-south1/functions/psql_connect_public
runtime: python37
serviceAccountEmail: 664290125703-compute@developer.gserviceaccount.com
sourceUploadUrl: https://storage.googleapis.com/uploads-515691363631.asia-south1.cloudfunctions.appspot.com/b5984f67-5819-42d4-80de-4f875f29e887.zip
status: ACTIVE
timeout: 60s
updateTime: '2022-10-07T15:13:31.533Z'
versionId: '2'
(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-function-cloud-sql/on-public-ip$ curl -m 70 -X POST https://asia-south1-shailesh-1.cloudfunctions.net/psql_connect_public -H "Authorization: bearer $(gcloud auth print-identity-token)" -H "Content-Type: application/json" -d '{}'
['pg_statistic', 'pg_type', 'pg_foreign_table', 'pg_authid', 'pg_statistic_ext_data', 'pg_user_mapping', 'pg_subscription', 'pg_attribute', 'pg_proc', 'pg_class', 'pg_attrdef', 'pg_constraint', 'pg_inherits', 'pg_index', 'pg_operator', 'pg_opfamily', 'pg_opclass', 'pg_am', 'pg_amop', 'pg_amproc', 'pg_language', 'pg_largeobject_metadata', 'pg_aggregate', 'pg_statistic_ext', 'pg_rewrite', 'pg_trigger', 'pg_event_trigger', 'pg_description', 'pg_cast', 'pg_enum', 'pg_namespace', 'pg_conversion', 'pg_depend', 'pg_database', 'pg_db_role_setting', 'pg_tablespace', 'pg_auth_members', 'pg_shdepend', 'pg_shdescription', 'pg_ts_config', 'pg_ts_config_map', 'pg_ts_dict', 'pg_ts_parser', 'pg_ts_template', 'pg_extension', 'pg_foreign_data_wrapper', 'pg_foreign_server', 'pg_policy', 'pg_replication_origin', 'pg_default_acl', 'pg_init_privs', 'pg_seclabel', 'pg_shseclabel', 'pg_collation', 'pg_partitioned_table', 'pg_range', 'pg_transform', 'pg_sequence', 'pg_publication', 'pg_publication_rel', 'pg_subscription_rel', 'pg_largeobject', 'sql_parts', 'sql_implementation_info', 'sql_features', 'sql_sizing'](base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-function-cloud-sql/on-public-ip$
(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-function-cloud-sql/on-public-ip$


