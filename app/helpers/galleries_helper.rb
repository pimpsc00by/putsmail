require 'digest/md5'
  
module GalleriesHelper
  def url2png_image_tag url
    security_hash = Digest::MD5.hexdigest(Url2png.private_key + url)
    image_tag "http://api.url2png.com/v3/#{Url2png.private_key}/#{security_hash}/400x300/#{url}"
  end
  
  def url2png_image_url url
    security_hash = Digest::MD5.hexdigest(Url2png.private_key + url)
    "http://api.url2png.com/v3/#{Url2png.private_key}/#{security_hash}/FULL/#{url}"
  end
end
