**Use Case 1 - Rafter as a static sites host**

This steps shows how you can easily create a Bucket and then push to it an Asset. The Asset here is a package containing all static files needed for a website, which are HTML, JS and CSS files.

Set variable to point to a location of released website
`export GH_WEBPAGE_URL=https://github.com/kyma-project/examples/archive/master.zip`{{execute}}

Create a Bucket that will contain final website files
```
cat <<EOF | kubectl apply -f -
apiVersion: rafter.kyma-project.io/v1beta1
kind: Bucket
metadata:
  name: pages
  namespace: default
spec:
  region: "us-east-1"
  policy: readonly
EOF
```{{execute}}

Create an Asset resource. Controller fetches the Asset from the location provuded in the `spec.source.url`. In this example you can see that what is fetched is a package from which only specific directory is filtered out.
```
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
EOF
```{{execute}}

Make sure that the Asset is in Ready status, as it means that fetching, unpacking and filtering is completed
`kubectl get assets webpage -o jsonpath='{.status.phase}'`{{execute}}
Add Bucket name to the environment variable
`export BUCKET_NAME=$(kubectl get bucket pages -o jsonpath='{.status.remoteName}')`{{execute}}

Echo and then copy the link and open it in a browser to see the website works fine
`echo https://[[HOST_SUBDOMAIN]]-31311-[[KATACODA_HOST]].environments.katacoda.com/$BUCKET_NAME/webpage/examples-master/asset-store/webpage/index.html`