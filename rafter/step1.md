WHAT ARE THE PRE_STEPS A USER CAN SEE IN THE TERMINAL? IS IT HELM INSTALLATION / TILLER INSTALLATION / MINIKUBE SET-UP? 
Make sure the environment is set up. Check if the API Server is running. 
It make take at least 1 minute, Minikube needs time, be patient.
`kubectl get pod -n kube-system | grep kube-apiserver-minikube`{{execute}} - DOES THE COMMAND CHECK IF MINKUBE IS SET UP CORRECTLY?

Initialize Helm to get Tiller running in Minikube - WHAT DO WE NEED TILLER FOR? WHAT DOES EACH OF THE COMMANDS DO?
`kubectl -n kube-system create serviceaccount tiller`{{execute}}
`kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller`{{execute}}
`helm init --service-account=tiller`{{execute}}

Check if Tiller is running - WHY?
`kubectl get deploy -n kube-system | grep tiller-deploy`{{execute}}

Install Rafter from dedicated Helm repository WHAT DOES EACH OF THE COMMANDS DO?
`helm repo add rafter-charts https://rafter-charts.storage.googleapis.com`{{execute}}

`helm install --name rafter --set rafter-controller-manager.minio.service.type=NodePort rafter-charts/rafter`{{execute}}

Clear the screen for next steps to not get lost in the stream of commands
`clear`{{execute}}

CAN WE USE STEPS (1,2,3..)? WOULD ADDITIONAL BLANK LINES SEPERATE SUBSEQUENT COMMANDS?