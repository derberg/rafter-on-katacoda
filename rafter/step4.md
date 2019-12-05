**Use Case 3 - Rafter as content storage using advanced webhook services**

>**NOTE:** In this scenario you reuse the `content` bucket created in the previous use case.

1. Export a URL to a single AsyncAPI specification file:

   `export ASYNCAPI_FILE_URL=https://raw.githubusercontent.com/asyncapi/asyncapi/master/examples/1.2.0/streetlights.yml`{{execute}}

2. Apply an Asset CR that points to a single [AsyncAPI](https://asyncapi.org/) specification file. To validate the specification and convert it to the latest 2.0 version before it goes into storage, in the Asset CR specify communication with **validationWebhookService** and **mutationWebhookService**. The webhook services are separate services responsible for the validation and conversion of AsyncAPI specifications. As a result, the file in storage will be an AsyncAPI file in 2.0 version.

   ```yaml
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

3. Make sure that the Asset status is `Ready` which means that fetching and communication with the AsyncAPI Service is completed. Run:

   `kubectl get assets asyncapi-file -o jsonpath='{.status.phase}'`{{execute}}

4. Make sure that the file is in storage and you can extract it. Export the Bucket name and the file name as environment variables:

   `export BUCKET_NAME=$(kubectl get bucket content -o jsonpath='{.status.remoteName}')`{{execute}}

   `export FILE_NAME=$(kubectl get asset asyncapi-file -o jsonpath='{.status.assetRef.files[0].name}')`{{execute}}

5. Fetch the file in the terminal window. It should start with `asyncapi: '2.0.0'`:

   `curl https://[[HOST_SUBDOMAIN]]-31311-[[KATACODA_HOST]].environments.katacoda.com/$BUCKET_NAME/asyncapi-file/$FILE_NAME`{{execute}}
