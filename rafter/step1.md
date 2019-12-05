The environment is set up and ready to start palying with Rafter.

Install Rafter from the dedicated Helm repository. Run:

   `helm repo add rafter-charts https://rafter-charts.storage.googleapis.com`{{execute}}

   `helm install --name rafter --set rafter-controller-manager.minio.service.type=NodePort rafter-charts/rafter`{{execute}}
