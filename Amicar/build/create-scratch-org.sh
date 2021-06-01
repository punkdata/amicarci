# Get the private key from the environment variable
echo "Setting up DevHub Connection..."
mkdir keys
echo $SFDX_JWT_KEY | base64 -d > keys/server.key

# Authenticate to salesforce
echo "Authenticating..."
sfdx force:auth:jwt:grant --clientid $SFDX_CONSUMER_KEY	 --jwtkeyfile keys/server.key --username $SFDC_PROD_USER --setdefaultdevhubusername -a DevHub

#Create a scratch org
echo "Creating the Scratch Org..."
sfdx force:org:create -f config/project-scratch-def.json -a ${amicarci} -s