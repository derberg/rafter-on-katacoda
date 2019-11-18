echo "Helm chart installation"
git clone https://github.com/magicmatatjahu/rafter.git
cd charts

#Install helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh
$ chmod 700 get_helm.sh
$ ./get_helm.sh

#Install chart
helm install --name rafter rafter-charts/rafter