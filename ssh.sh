gcloud compute start-iap-tunnel <instance Name> 22 \
  --zone=<Your zone> --local-host-port=localhost:4226
  
  
gcloud compute start-iap-tunnel instance-mumbai 22 \
  --zone=asia-south1-c --local-host-port=localhost:4226
  
 ssh -L 3306:localhost:3306 \
  -i ~/.ssh/google_compute_engine \
  -p 4226 localhost \
  -- /tmp/cloud_sql_proxy instances=<connection_name>=tcp:3306
  
ssh -L 3306:localhost:3306 \
  -i ~/.ssh/google_compute_engine \
  -p 4226 localhost \
  -- /tmp/cloud_sql_proxy instances=shailesh-1:asia-south1:pg-db11=tcp:3306
  
  gcloud compute scp /local/path/to/cloud_sql_proxy <instanceName>:/tmp
  
  gcloud compute scp ./cloud_sql_proxy instance-mumbai:/tmp
  
  
