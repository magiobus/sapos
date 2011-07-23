require 'google_util'
require 'base64'

module ProfilePictureHelper
  def profile_picture(email)
    #TODO: Implement some kind of cache
    oauth_consumer = OAuth::Consumer.new(GAPPS_CONSUMER_KEY, GAPPS_CONSUMER_SECRET)
    access_token = OAuth::AccessToken.new(oauth_consumer)
    client = Google::Client.new(access_token, '2.0')
    username = email.split('@'+GAPPS_DOMAIN)[0]
    url = "https://www.google.com/m8/feeds/photos/profile/#{GAPPS_DOMAIN}/#{username}"
    img = client.get(url, {
        'xoauth_requestor_id' => GAPPS_REQUESTOR_ID
    }, false)
    if img.nil?
      "/images/default_picture.jpg"
    else
      b64 = Base64.encode64(img)
      "data:image/gif;base64,#{b64}"
    end
  end
end
