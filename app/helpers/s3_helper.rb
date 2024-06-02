# app/helpers/s3_helper.rb
module S3Helper
  def s3_storage
    @s3_storage ||= Fog::Storage.new({
                                       provider:              'AWS',
                                       aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
                                       aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                       region:                ENV['AWS_REGION'],
                                     })
  end

  def generate_signed_url(menu_item)
    Rails.logger.info "Generating signed URL for menu_item: #{menu_item.inspect}"
    directory = s3_storage.directories.get(ENV['AWS_S3_BUCKET'])

    # Extract filename from the image_url uploader
    filename = File.basename(menu_item.image_url.url)

    # Include the cafe's subdomain in the file path
    file_path = "#{Rails.env}/#{menu_item.cafe.subdomain}/#{menu_item.class.to_s.underscore}/#{menu_item.category.id}/#{filename}"
    Rails.logger.info "File path: #{file_path}"

    file = directory.files.get(file_path)
    if file
      signed_url = file.url(Time.now + 3600) # URL valid for 1 hour
      Rails.logger.info "Signed URL: #{signed_url}"
      signed_url
    else
      Rails.logger.error "File not found: #{file_path}"
      nil
    end
  end
end
