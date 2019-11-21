Script environment is available here: https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/

export GH_WEBPAGE_URL=https://github.com/kyma-project/examples/archive/master.zip{{execute}}


cat <<EOF | kubectl apply -f -
apiVersion: rafter.kyma-project.io/v1beta1
kind: Bucket
metadata:
  name: pages
  namespace: default
spec:
  region: "us-east-1"
  policy: readonly
EOF{{execute}}


cat <<EOF | kubectl apply -f -
apiVersion: rafter.kyma-project.io/v1beta1
kind: Asset
metadata:
  name: webpage
  namespace: default
spec:
  source:
    url: ${GH_WEBPAGE_URL}
    mode: package
    filter: /asset-store/webpage/
  bucketRef:
    name: pages
EOF{{execute}}

kubectl get assets webpage -o jsonpath='{.status.phase}'{{execute}}

curl $(kubectl get assets webpage -o jsonpath='{.status.assetRef.baseUrl}{"/examples-master/asset-store/webpage/index.html"}'){{execute}}