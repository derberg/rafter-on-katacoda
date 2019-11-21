
Make sure the environment is set up. Check if the API Server is running
`kubectl get pod -n kube-system | grep kube-apiserver-minikube`{{execute}}

Initialize Helm to get Tiller running in Minikube
`kubectl -n kube-system create serviceaccount tiller`{{execute}}
`kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller`{{execute}}
`helm init --service-account=tiller`{{execute}}

Check if Tiller is running
`kubectl get deploy -n kube-system | grep tiller-deploy`{{execute}}

Install Rafter from dedicated Helm repository
`helm repo add rafter-charts https://rafter-charts.storage.googleapis.com`{{execute}}

`helm install --name rafter --set rafter-controller-manager.minio.service.type=NodePort rafter-charts/rafter`{{execute}}

Clear the screen for next steps to not get lost in the stream of commands
`clear`{{execute}}