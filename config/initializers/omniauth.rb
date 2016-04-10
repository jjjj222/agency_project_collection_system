Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"],
    scope: 'profile, email', image_aspect_ratio: 'square', image_size: 48, access_type: 'online',
      client_options: {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}
end