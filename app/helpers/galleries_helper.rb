require 'digest/md5'
  
module GalleriesHelper
  # def url2png_image_tag url
  #   image_tag "http://api.url2png.com/v3/#{Url2png.api_key}/#{security_hash(url)}/400x300/#{url}"
  # end
  
  def url2png_image_url url
    "http://api.url2png.com/v3/#{Url2png.api_key}/#{security_hash(url)}/FULL/#{url}"
  end
  
  private
  
  def security_hash url
    Digest::MD5.hexdigest("#{Url2png.private_key}+#{url}")
  end
end
