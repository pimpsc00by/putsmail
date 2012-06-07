require 'digest/md5'
  
module GalleriesHelper
  def url2png_image_tag url
    image_tag "http://api.url2png.com/v3/#{Url2png.api_key}/#{security_hash(url)}/400x300/#{url}"
  end
  
  def url2png_image_url url
    "http://api.url2png.com/v3/#{Url2png.api_key}/#{security_hash(url)}/FULL/#{url}"
  end
  
  private
  
  def security_hash url
    Digest::MD5.hexdigest("#{Url2png.private_key}+#{url}")
  end
end
# boa
# http://api.url2png.com/v3/P4FD0EFDE615DF/e76a75015b1a6e3cfffb6ef02c9281f2/300x300/http://putsmail.com/galleries/3810
# ruim
# http://api.url2png.com/v3/SE2C794374A4CE/5487be0637243806774bda7001861b8c/400x300/http://putsmail.com/galleries/3810
