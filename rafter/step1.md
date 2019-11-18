
Make sure the environment is set up. Check if the API Server is running
`kubectl get pod -n kube-system | grep kube-apiserver-minikube`{{execute}}

Initialize Helm to get Tiller running in Minikube
`helm init`{{execute}}

Check if Tiller is running
`kubectl get deploy -n kube-system | grep tiller-deploy`{{execute}}

Install Rafter
`helm install --name rafter ./charts/rafter --debug`{{execute}}