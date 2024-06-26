require 'carrierwave/storage/fog'
Dotenv.load if Rails.env.development? || Rails.env.test?

CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region:                ENV['AWS_REGION'],
  }
  config.fog_directory  = ENV['AWS_S3_BUCKET']
  config.fog_public     = false # Set to true if you want the files to be publicly accessible
end
