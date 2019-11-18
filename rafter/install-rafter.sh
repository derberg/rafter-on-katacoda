echo "Helm chart cloning"
git clone https://github.com/magicmatatjahu/rafter.git
cd charts

echo "Helm chart installation"
helm install --name rafter rafter-charts/rafter --verbose