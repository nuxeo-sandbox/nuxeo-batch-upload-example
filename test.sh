myURL=http://localhost:8080/nuxeo/api/v1
myDestination=/path/default-domain/workspaces/asdasdad
myUser=Administrator
myPassword=Administrator
myFirstFile=cat.psd
myFirstMimeType=application/photoshop
mySecondFile=happy.jpg
mySecondMimeType=image/jpeg

# Start a batch
batchId=`curl -u $myUser:$myPassword -X POST "$myURL/upload" | jq -r '.batchId'`

# Upload binaries
curl -u $myUser:$myPassword -X POST -H "X-File-Name:$myFirstFile" -H "X-File-Type:$myFirstMimeType" -T $myFirstFile "$myURL/upload/$batchId/0"
curl -u $myUser:$myPassword -X POST -H "X-File-Name:$mySecondFile" -H "X-File-Type:$application/photoshop" -T $mySecondFile "$myURL/upload/$batchId/1"

# Create documents
curl -X POST -H 'Content-Type: application/json' -u $myUser:$myPassword -d "{\"entity-type\": \"document\", \"name\": \"$myFirstFile\", \"type\": \"Picture\", \"properties\": {\"dc:title\": \"$myFirstFile\", \"file:content\": {\"upload-batch\": \"$batchId\", \"upload-fileId\": \"0\"}}}" $myURL$myDestination
curl -X POST -H 'Content-Type: application/json' -u $myUser:$myPassword -d "{\"entity-type\": \"document\", \"name\": \"$mySecondFile\", \"type\": \"Picture\", \"properties\": {\"dc:title\": \"$mySecondFile\", \"file:content\": {\"upload-batch\": \"$batchId\", \"upload-fileId\": \"1\"}}}" $myURL$myDestination
