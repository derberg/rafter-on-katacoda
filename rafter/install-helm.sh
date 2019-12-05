#echo "Upgrade to Helm 1.16.0"
curl -LO https://get.helm.sh/helm-"v2.16.0"-linux-amd64.tar.gz
tar -xzvf helm-"v2.16.0"-linux-amd64.tar.gz
mv ./linux-amd64/{helm,tiller} /usr/local/bin