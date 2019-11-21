**Use Case 3 - Rafter as a content storage with advanced webhook services usage**

Set variable to point to a location of a single AsyncAPI specification file
`export ASYNCAPI_FILE_URL=https://raw.githubusercontent.com/asyncapi/asyncapi/master/examples/1.2.0/streetlights.yml`{{execute}}

>In this use case you reuse `content` bucket created in previous step, previous use case.

Create an Asset resource that points to a single [AsyncAPI](https://asyncapi.org/) spec file. You want to validate the specification and convert it to latest 2.0 version before it goes into storage. For this reason you specify a communication with the `validationWebhookService` and the `mutationWebhookService`. As a result the file in the storage should contain AsyncAPI file in 2.0 version.
```
cat <<EOF | kubectl apply -f -
apiVersion: rafter.kyma-project.io/v1beta1
kind: Asset
metadata:
  name: asyncapi-file
  namespace: default
spec:
  source:
    url: ${ASYNCAPI_FILE_URL}
    mode: single
    validationWebhookService:
      - name: rafter-rafter-asyncapi-service
        namespace: default
        endpoint: "/v1/validate"
    mutationWebhookService:
      - name: rafter-rafter-asyncapi-service
        namespace: default
        endpoint: "/v1/convert"
  bucketRef:
    name: content
EOF
```{{execute}}

Make sure that the Asset is in Ready status, as it means that fetching and communication for Front Matter service is completed.
`kubectl get assets asyncapi-file -o jsonpath='{.status.phase}'`{{execute}}

Time for checking if the file is now really in the storage and you can extract it:

Add Bucket name to the environment variable
`export BUCKET_NAME=$(kubectl get bucket content -o jsonpath='{.status.remoteName}')`{{execute}}
`export FILE_NAME=$(kubectl get asset markdown-file -o jsonpath='{.status.assetRef.files[0].name}')`{{execute}}

Try to fetch the file in the terminal
`curl https://[[HOST_SUBDOMAIN]]-31311-[[KATACODA_HOST]].environments.katacoda.com/$BUCKET_NAME/$FILE_NAME`{{execute}}

The file should start with `asyncapi: '2.0.0'`