**Use Case 2 - Rafter as a content storage with webhook services usage**

Set variable to point to a location of a single markdown file
`export MARKDOWN_FILE_URL=https://gist.githubusercontent.com/derberg/01666184bac1ddb4b388c31739924dca/raw/b1d0aff9dcc5f5ee309c33d330b9ba23de470da0/sample-markdown.md`{{execute}}


Create a Bucket that will contain content files
```
cat <<EOF | kubectl apply -f -
apiVersion: rafter.kyma-project.io/v1beta1
kind: Bucket
metadata:
  name: content
  namespace: default
spec:
  region: "us-east-1"
  policy: readonly
EOF
```{{execute}}

Create an Asset resource that points to a single markdown. You want to extract metadata added to the markdown before it is goes into the storage. For this reason you specify a communication with the `metadataWebhookService` that is a separate service responsible for extracting metadata from Markdown files. As a result the status of the Asset resource will be enhanced with additional metadata for the file.
```
cat <<EOF | kubectl apply -f -
apiVersion: rafter.kyma-project.io/v1beta1
kind: Asset
metadata:
  name: markdown-file
  namespace: default
spec:
  source:
    url: ${MARKDOWN_FILE_URL}
    mode: single
    metadataWebhookService:
      - name: rafter-rafter-front-matter-service
        namespace: default
        endpoint: "/v1/extract"
  bucketRef:
    name: content
EOF
```{{execute}}

Make sure that the Asset is in Ready status, as it means that fetching and communication for Front Matter service is completed.
`kubectl get assets markdown-file -o jsonpath='{.status.phase}'`{{execute}}

Check of the status of the Asset resource. It now has additional Metadata object with set of values. In this example we know there should be a `title` key with some value.
`kubectl get asset markdown-file -o jsonpath='{.status.assetRef.files[0].metadata.title}'`{{execute}}

Time for checking if the file is now really in the storage and you can extract it:

Add Bucket name to the environment variable
`export BUCKET_NAME=$(kubectl get bucket content -o jsonpath='{.status.remoteName}')`{{execute}}
`export FILE_NAME=$(kubectl get asset markdown-file -o jsonpath='{.status.assetRef.files[0].name}')`{{execute}}

Try to fetch the file in the terminal
`curl https://[[HOST_SUBDOMAIN]]-31311-[[KATACODA_HOST]].environments.katacoda.com/$BUCKET_NAME/$FILE_NAME`{{execute}}