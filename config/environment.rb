# Config
GAPPS_DOMAIN = 'your-domain.com'
GAPPS_CONSUMER_KEY = GAPPS_DOMAIN
GAPPS_CONSUMER_SECRET = 'your-consumer-googleapps-key'
GAPPS_REQUESTOR_ID = 'some.admin@your-domain.com'

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sapos::Application.initialize!

