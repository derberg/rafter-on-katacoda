echo "Helm chart cloning"
git clone https://github.com/magicmatatjahu/rafter.git
cd rafter
git checkout chart

echo "Helm chart setup"
helm init

echo "Helm chart installation"
helm install --name rafter ./charts/rafter --debug