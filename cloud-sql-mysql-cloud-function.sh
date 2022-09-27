https://blog.pythian.com/how-to-connect-from-cloud-functions-to-the-private-ip-address-of-cloud-sql-in-google-cloud/


create serverless VPC connector for Private IP based Cloud SQL

https://cloud.google.com/sql/docs/postgres/connect-functions#private-ip_1



cat requirements.txt

cat main.py

in same dir where main.py and requirements.txt exist, run following to deploy the cloud function along with the code:

gcloud beta functions deploy sql_connect --runtime python37 --project shailesh-1 --region asia-south1 --vpc-connector serverless-1 --trigger-http --service-account 664290125703-compute@developer.gserviceaccount.com

Test with following format:

curl -m 70 -X POST https://asia-south1-shailesh-1.cloudfunctions.net/sql_connect \
-H "Authorization: bearer $(gcloud auth print-identity-token)" \
-H "Content-Type: application/json" \
-d '{}'








admin_shkm_altostrat_com@instance-mumbai:~/bigtable$ cat requirements.txt
pymysql
sqlalchemy
admin_shkm_altostrat_com@instance-mumbai:~/bigtable$


admin_shkm_altostrat_com@instance-mumbai:~/bigtable$ cat main.py
import pymysql
from sqlalchemy import create_engine
def sql_connect(request):
  engine = create_engine('mysql+pymysql://root:Welcome0@10.45.193.27/mysql',echo=True)
  tab = engine.execute('show tables;')
  return str([t[0] for t in tab])

admin_shkm_altostrat_com@instance-mumbai:~/bigtable$ gcloud beta functions deploy sql_connect --runtime python37 --project shailesh-1 --region asia-south1 --vpc-connector serverless-1 --trigger-http --service-account 664290125703-compute@developer.gserviceaccount.com
Deploying function (may take a while - up to 2 minutes)...⠼
For Cloud Build Logs, visit: https://console.cloud.google.com/cloud-build/builds;region=asia-south1/5254e70c-d60c-4ba9-9c73-583c79a69aaa?project=664290125703
Deploying function (may take a while - up to 2 minutes)...done.
availableMemoryMb: 256
buildId: 5254e70c-d60c-4ba9-9c73-583c79a69aaa
buildName: projects/664290125703/locations/asia-south1/builds/5254e70c-d60c-4ba9-9c73-583c79a69aaa
dockerRegistry: CONTAINER_REGISTRY
entryPoint: sql_connect
httpsTrigger:
  securityLevel: SECURE_OPTIONAL
  url: https://asia-south1-shailesh-1.cloudfunctions.net/sql_connect
ingressSettings: ALLOW_ALL
labels:
  deployment-tool: cli-gcloud
name: projects/shailesh-1/locations/asia-south1/functions/sql_connect
runtime: python37
serviceAccountEmail: 664290125703-compute@developer.gserviceaccount.com
sourceUploadUrl: https://storage.googleapis.com/uploads-515691363631.asia-south1.cloudfunctions.appspot.com/505ce93f-6d1c-4c9d-9379-af9ee6ba6f57.zip
status: ACTIVE
timeout: 60s
updateTime: '2022-09-27T13:43:41.829Z'
versionId: '5'
vpcConnector: serverless-1
vpcConnectorEgressSettings: PRIVATE_RANGES_ONLY
admin_shkm_altostrat_com@instance-mumbai:~/bigtable$

admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$ curl -m 70 -X POST https://asia-south1-shailesh-1.cloudfunctions.net/sql_connect \
> -H "Authorization: bearer $(gcloud auth print-identity-token)" \
> -H "Content-Type: application/json" \
> -d '{}'
['audit_log_rules', 'audit_log_rules_expanded', 'audit_log_supported_ops', 'cloudsql_replica_index', 'columns_priv', 'component', 'db', 'default_roles', 'engine_cost', 'func', 'general_log', 'global_grants', 'gtid_executed', 'heartbeat', 'help_category', 'help_keyword', 'help_relation', 'help_topic', 'innodb_index_stats', 'innodb_table_stats', 'password_history', 'plugin', 'procs_priv', 'proxies_priv', 'replication_asynchronous_connection_failover', 'replication_asynchronous_connection_failover_managed', 'replication_group_configuration_version', 'replication_group_member_actions', 'role_edges', 'server_cost', 'servers', 'slave_master_info', 'slave_relay_log_info', 'slave_worker_info', 'slow_log', 'tables_priv', 'time_zone', 'time_zone_leap_second', 'time_zone_name', 'time_zone_transition', 'time_zone_transition_type', 'user']admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$
admin_shkm_altostrat_com@instance-mumbai:~/bigtable/pg$





