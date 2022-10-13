https://cloud.google.com/sql/docs/mysql/replication/configure-replication-from-external


      CREATE USER 'USERNAME'@'%' IDENTIFIED BY 'PASSWORD';
      GRANT SELECT, SHOW VIEW ON *.* TO 'USERNAME'@'HOST';
      FLUSH PRIVILEGES;


      CREATE USER 'myrep1'@'%' IDENTIFIED BY 'Welcome0';
      GRANT SELECT, SHOW VIEW ON *.* TO 'myrep1'@'%';
      FLUSH PRIVILEGES;     


   {
      "name": "mysource1",
      "region": "asia-south1",
      "databaseVersion": "MYSQL_8_0",
      "onPremisesConfiguration": {
        "hostPort": "10.0.4.25:3306",
        "username": "myrep1",
        "password": "Welcome0"
      }
    }

ALTER USER 'yourusername'@'localhost' IDENTIFIED WITH mysql_native_password BY 'youpassword';

ALTER USER 'myrep1' IDENTIFIED WITH mysql_native_password BY 'Welcome0';


    gcloud auth login
    ACCESS_TOKEN="$(gcloud auth print-access-token)"
    curl --header "Authorization: Bearer ${ACCESS_TOKEN}" \
         --header 'Content-Type: application/json' \
         --data @JSON_PATH \
         -X POST \
         https://sqladmin.googleapis.com/sql/v1beta4/projects/PROJECT-ID/instances


    gcloud auth login
    ACCESS_TOKEN="$(gcloud auth print-access-token)"



    curl --header "Authorization: Bearer ${ACCESS_TOKEN}" \
         --header 'Content-Type: application/json' \
         --data @./source.json \
         -X POST \
         https://sqladmin.googleapis.com/sql/v1beta4/projects/shailesh-1/instances

{
        "settings": {
            "tier": "db-custom-4-15360",
            "dataDiskSizeGb": "10"
        },
        "masterInstanceName": "source-instance",
        "region": "us-central1",
        "databaseVersion": "MYSQL_5_7",
        "name": "replica-instance"
    }



    {
        "settings": {
            "tier": "db-custom-4-15360",
            "dataDiskSizeGb": "10",
            "ipConfiguration": {
                "privateNetwork": "projects/shailesh-1/global/networks/sh-vpc"
             },
             "availabilityType": "REGIONAL"
        },
        "masterInstanceName": "mysource1",
        "region": "asia-south1",
        "databaseVersion": "MYSQL_8_0",
        "name": "myreplica1"
    }


gcloud auth login
    ACCESS_TOKEN="$(gcloud auth print-access-token)"
    curl --header "Authorization: Bearer ${ACCESS_TOKEN}" \
         --header 'Content-Type: application/json' \
         --data @./replica.json \
         -X POST \
         https://sqladmin.googleapis.com/sql/v1beta4/projects/shailesh-1/instances


    UPDATE mysql.myrep1
    SET Host='NEW_HOST'
    WHERE Host='OLD_HOST'
    AND User='USERNAME';
    GRANT REPLICATION SLAVE, EXECUTE, SELECT, SHOW VIEW, REPLICATION CLIENT,
    RELOAD ON . TO 'GCP_USERNAME'@'HOST';
    FLUSH PRIVILEGES;



GRANT REPLICATION SLAVE, EXECUTE, SELECT, SHOW VIEW, REPLICATION CLIENT,
RELOAD ON *.* TO 'myrep1';
FLUSH PRIVILEGES;


gcloud auth login
ACCESS_TOKEN="$(gcloud auth print-access-token)"
curl --header "Authorization: Bearer ${ACCESS_TOKEN}" \
     --header 'Content-Type: application/json' \
     --data '{
         "syncMode": "SYNC_MODE",
         "mysqlSyncConfig": {
           "initialSyncFlags": "SYNC_FLAGS"
         }
       }' \
     -X POST \
     https://sqladmin.googleapis.com/sql/v1beta4/projects/PROJECT_ID/instances/REPLICA_INSTANCE/verifyExternalSyncSettings


gcloud auth login
ACCESS_TOKEN="$(gcloud auth print-access-token)"
curl --header "Authorization: Bearer ${ACCESS_TOKEN}" \
     --header 'Content-Type: application/json' \
     --data '{
         "syncMode": "online",
         "mysqlSyncConfig": {
             "initialSyncFlags": [{"name": "max-allowed-packet", "value": "1073741824"}, {"name": "hex-blob"}, {"name": "compress"}, {"name": "databases", "value": "db1 db2"}]
             }
       }' \
     -X POST \
     https://sqladmin.googleapis.com/sql/v1beta4/projects/shailesh-1/instances/myreplica1/verifyExternalSyncSettings

curl --header "Authorization: Bearer ${ACCESS_TOKEN}" \
     --header 'Content-Type: application/json' \
     --data '{
         "syncMode": "online"
       }' \
     -X POST \
     https://sqladmin.googleapis.com/sql/v1beta4/projects/shailesh-1/instances/myreplica1/verifyExternalSyncSettings

update mysql.user set host='%' where user='root';
FLUSH PRIVILEGES;

startExternalSync

curl --header "Authorization: Bearer ${ACCESS_TOKEN}" \
     --header 'Content-Type: application/json' \
     --data '{
         "syncMode": "online"
       }' \
     -X POST \
     https://sqladmin.googleapis.com/sql/v1beta4/projects/shailesh-1/instances/myreplica1/startExternalSync



describe INFORMATION_SCHEMA.views;

select distinct definer from INFORMATION_SCHEMA.views;

select table_name from INFORMATION_SCHEMA.views where definer='root@localhost';

update INFORMATION_SCHEMA.views
set definer='root@%'
where definer='root@localhost';

echo "SELECT CONCAT("ALTER DEFINER=`youruser`@`host` VIEW `",table_name,"` AS ", view_definition,";") 
FROM information_schema.views WHERE table_schema='databasename'" | mysql -uuser -p > alterView.sql

mysql -uroot -pWelcome0 -A --skip-column-names -e"SELECT CONCAT('SHOW CREATE VIEW ',table_schema,'.',table_name,'\\G') FROM information_schema.tables WHERE engine IS NULL" | mysql -uroot -pWelcome0 -A --skip-column-names > AllMyViews.sql


insert into departments (dept_no,dept_name) values('d100','TestIT');

update departments
set dept_name = 'IT-Tested'
where dept_no = 'd100';




===============================================================================================================
Using Custom dump export and import
===============================================================================================================



SET @@GLOBAL.read_only = ON;

SET @@GLOBAL.gtid_mode = ON;
SET @@enforce-gtid-consistency = ON;

mysql> show global variables like '%GTID%';
+----------------------------------+-------+
| Variable_name                    | Value |
+----------------------------------+-------+
| binlog_gtid_simple_recovery      | ON    |
| enforce_gtid_consistency         | OFF   |
| gtid_executed                    |       |
| gtid_executed_compression_period | 0     |
| gtid_mode                        | OFF   |
| gtid_owned                       |       |
| gtid_purged                      |       |
| session_track_gtids              | OFF   |
+----------------------------------+-------+
8 rows in set (0.01 sec)

mysql> SET @@enforce-gtid-consistency = OFF_PERMISSIVE;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '-gtid-consistency = OFF_PERMISSIVE' at line 1
mysql> SET @@GLOBAL.gtid_mode = OFF_PERMISSIVE;
Query OK, 0 rows affected (0.01 sec)

mysql> SET @@GLOBAL.gtid_mode = ON_PERMISSIVE;
Query OK, 0 rows affected (0.01 sec)

mysql> SET @@GLOBAL.gtid_mode = ON;
ERROR 3111 (HY000): SET @@GLOBAL.GTID_MODE = ON is not allowed because ENFORCE_GTID_CONSISTENCY is not ON.
mysql> SET @@GLOBAL.ENFORCE_GTID_CONSISTENCY = ON;
Query OK, 0 rows affected (0.00 sec)

mysql> SET @@GLOBAL.gtid_mode = ON;
Query OK, 0 rows affected (0.01 sec)

mysql>



{
        "settings": {
            "tier": "db-custom-4-15360",
            "dataDiskSizeGb": "10",
            "ipConfiguration": {
                "privateNetwork": "projects/shailesh-1/global/networks/sh-vpc"
             },
             "availabilityType": "REGIONAL"
        },
        "masterInstanceName": "mysource1",
        "region": "asia-south1",
        "databaseVersion": "MYSQL_8_0",
        "name": "myreplica2"
    }


gcloud auth login
    ACCESS_TOKEN="$(gcloud auth print-access-token)"
    curl --header "Authorization: Bearer ${ACCESS_TOKEN}" \
         --header 'Content-Type: application/json' \
         --data @./replica.json \
         -X POST \
         https://sqladmin.googleapis.com/sql/v1beta4/projects/shailesh-1/instances







curl --header "Authorization: Bearer ${ACCESS_TOKEN}" \
     --header 'Content-Type: application/json' \
     --data '{
         "syncMode": "online"
       }' \
     -X POST \
     https://sqladmin.googleapis.com/sql/v1beta4/projects/shailesh-1/instances/myreplica2/verifyExternalSyncSettings

update mysql.user set host='%' where user='root';
FLUSH PRIVILEGES;

startExternalSync

curl --header "Authorization: Bearer ${ACCESS_TOKEN}" \
     --header 'Content-Type: application/json' \
     --data '{
         "syncMode": "online"
       }' \
     -X POST \
     https://sqladmin.googleapis.com/sql/v1beta4/projects/shailesh-1/instances/myreplica2/startExternalSync


(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-sql/mysql/rep-ext$ curl --header "Authorization: Bearer ${ACCESS_TOKEN}"      --header 'Content-Type: application/json'      --data '{
         "syncMode": "online"
       }'      -X POST      https://sqladmin.googleapis.com/sql/v1beta4/projects/shailesh-1/instances/myreplica2/verifyExternalSyncSettings
{
  "error": {
    "code": 409,
    "message": "The instance or operation is not in an appropriate state to handle the request.",
    "errors": [
      {
        "message": "The instance or operation is not in an appropriate state to handle the request.",
        "domain": "global",
        "reason": "invalidState"
      }
    ]
  }
}

wait for some time as it will finish creating replica

(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-sql/mysql/rep-ext$ curl --header "Authorization: Bearer ${ACCESS_TOKEN}"      --header 'Content-Type: application/json'      --data '{
         "syncMode": "online"
       }'      -X POST      https://sqladmin.googleapis.com/sql/v1beta4/projects/shailesh-1/instances/myreplica2/verifyExternalSyncSettings
{
  "kind": "sql#externalSyncSettingErrorList"
}



GRANT REPLICATION SLAVE, EXECUTE, SELECT, SHOW VIEW, REPLICATION CLIENT,
RELOAD ON *.* TO 'myrep1';
FLUSH PRIVILEGES;


   $ mydumper -u USERNAME -p PASSWORD \
              --threads=16 -o ./backup \
              -h HOST \
              --no-locks \
              --regex '^(?!(mysql\.|sys\.))'


mydumper -u root -p Welcome0 \
              --threads=16 -o ./backup \
              -h 10.0.4.25 \
              --no-locks \
              --regex '^(?!(mysql\.|sys\.))'


(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-sql/mysql/rep-ext$ ls
backup  replica.json  replica.json.1  source.json

(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-sql/mysql/rep-ext/backup$ ls
employees-schema-create.sql       employees.dept_emp-schema.sql      employees.dept_manager.sql      employees.salaries-schema.sql  employees.titles.sql
employees.departments-schema.sql  employees.dept_emp.sql             employees.employees-schema.sql  employees.salaries.sql         metadata
employees.departments.sql         employees.dept_manager-schema.sql  employees.employees.sql         employees.titles-schema.sql

(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-sql/mysql/rep-ext/backup$
(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-sql/mysql/rep-ext/backup$ grep -i "gtid" *
metadata:	GTID:

(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-sql/mysql/rep-ext/backup$ cat metadata
Started dump at: 2022-10-13 11:25:40
SHOW MASTER STATUS:
	Log: binlog.000006
	Pos: 157
	GTID:

Finished dump at: 2022-10-13 11:25:42
(base) admin_shkm_altostrat_com@instance-mumbai:~/cloud-sql/mysql/rep-ext/backup$


 $ myloader -u REPLICA_USERNAME -p REPLICA_PASSWORD \
            --threads=16 \
            -d ./backup -h HOST -o

promote repica to primary instance and import the data            

myloader -u root -p Welcome0 \
            --threads=16 \
            -d ./backup -h 10.45.193.44 -o            




demote 

 {
    "demoteMasterContext": {
      "masterInstanceName": SOURCE_REPRESENTATION_INSTANCE_NAME,
      "skipReplicationSetup": true
      }
 }


{
    "demoteMasterContext": {
      "masterInstanceName": mysource1,
      "skipReplicationSetup": true
      }
 }

gcloud auth login

ACCESS_TOKEN="$(gcloud auth print-access-token)"

curl --header "Authorization: Bearer ${ACCESS_TOKEN}" \
    --header 'Content-Type: application/json' \
    --data @JSON_PATH \
    -X POST \
  https://sqladmin.googleapis.com/sql/v1beta4/projects/PROJECT-ID/instances/INSTANCE-NAME/demoteMaster



   gcloud auth login
   
   ACCESS_TOKEN="$(gcloud auth print-access-token)"
   
curl --header "Authorization: Bearer ${ACCESS_TOKEN}" \
    --header 'Content-Type: application/json' \
    --data @./s1.json \
    -X POST \
   https://sqladmin.googleapis.com/sql/v1beta4/projects/shailesh-1/instances/myreplica2/demoteMaster

call mysql.resetMaster();

call mysql.skipTransactionWithGtid('32eb1e6a-17b6-11ea-a39e-06d94ac3ec98:1-33496');


call mysql.setupExternalSource('1.1.1.1', 3306, \
    'user_name', 'password', 'mysql-bin-changelog.033877', 360, \
    false, false);

call mysql.setupExternalSource('10.0.4.25', 3306, \
    'myrep1', 'Welcome0', 'binlog.000006', 157, \
    false, false);

call mysql.startReplication();

show slave status\G

select * from departments;

insert into departments (dept_no,dept_name) values('d101','TestITver2');

update departments
set dept_name = 'IT-Tested-ver2'
where dept_no = 'd101';




