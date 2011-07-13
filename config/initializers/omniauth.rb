require 'openid/store/filesystem'

# Set the default hostname for omniauth to send callbacks to.
# OmniAuth.config.full_host = "http://posgrado.cimav.edu.mx:80"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_apps, OpenID::Store::Filesystem.new('/tmp'), :domain => 'cimav.edu.mx', :name => 'admin'
end

