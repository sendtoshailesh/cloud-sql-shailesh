
$
$ export PSO_DV_CONFIG_HOME=gs://bqexp-shailesh/
$
$ data-validation connections add --connection-name MYSRC MySQL --host 10.0.4.25 --port 3306 --user root --password Welcome0 --database employees
10/21/2022 12:32:55 PM-INFO: Success! Config output written to gs://bqexp-shailesh/connections/MYSRC.connection.json
$
$ data-validation connections add --connection-name MYTGT MySQL --host 10.45.193.27 --port 3306 --user root --password Welcome0 --database employees
10/21/2022 12:48:18 PM-INFO: Success! Config output written to gs://bqexp-shailesh/connections/MYTGT.connection.json
$
$ data-validation validate column -sc MYSRC -tc MYTGT -tbls employees.departments
╒═══════════════════╤═══════════════════╤═══════════════════════╤══════════════════════╤════════════════════╤════════════════════╤══════════════════╤═════════════════════╕
│ validation_name   │ validation_type   │ source_table_name     │ source_column_name   │   source_agg_value │   target_agg_value │   pct_difference │ validation_status   │
╞═══════════════════╪═══════════════════╪═══════════════════════╪══════════════════════╪════════════════════╪════════════════════╪══════════════════╪═════════════════════╡
│ count             │ Column            │ employees.departments │                      │                 11 │                  9 │         -18.1818 │ fail                │
╘═══════════════════╧═══════════════════╧═══════════════════════╧══════════════════════╧════════════════════╧════════════════════╧══════════════════╧═════════════════════╛
$




