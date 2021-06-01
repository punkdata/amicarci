# Get the private key from the environment variable
echo "Setting up Production Connection..."
mkdir keys
echo $SFDX_CONSUMER_KEY | base64 -d > keys/server.key

# Authenticate to salesforce
echo "Authenticating..."
sfdx force:auth:jwt:grant --clientid $SFDX_JWT_KEY --jwtkeyfile keys/server.key --username $SFDC_PROD_USER --setdefaultdevhubusername -a DevHub