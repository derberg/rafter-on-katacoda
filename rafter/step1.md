
Make sure the environment is set up. Check if the API Server is running
`kubectl get pod -n kube-system | grep kube-apiserver-minikube`{{execute}}

Initialize Helm to get Tiller running in Minikube
`kubectl -n kube-system create serviceaccount tiller`{{execute}}
`kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller`{{execute}}
`helm init --service-account=tiller`{{execute}}

Check if Tiller is running
`kubectl get deploy -n kube-system | grep tiller-deploy`{{execute}}

Install Rafter
`helm repo add rafter-charts https://rafter-charts.storage.googleapis.com`{{execute}}
`helm repo update`{{execute}}
`helm install --name rafter --set minio.service.type=NodePort rafter-charts/rafter`{{execute}}