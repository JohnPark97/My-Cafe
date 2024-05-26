namespace :test do
  desc "Test S3 connection and retrieve coffee.jpeg"
  task s3: :environment do
    require 'fog/aws'

    s3 = Fog::Storage.new({
                            provider:              'AWS',
                            aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
                            aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                            region:                ENV['AWS_REGION'],
                          })

    directory = s3.directories.get(ENV['AWS_S3_BUCKET'])
    file = directory.files.get('coffee.jpeg')

    if file
      signed_url = file.url(Time.now + 3600) # URL valid for 1 hour
      puts "Successfully retrieved 'coffee.jpeg'."
      puts "Signed URL: #{signed_url}"
    else
      puts "Failed to retrieve 'coffee.jpeg'."
    end
  end
end
