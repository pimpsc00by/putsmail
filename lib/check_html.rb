class CheckHtml
  def self.check_it html
    premailer = Premailer.new html, {:warn_level => Premailer::Warnings::SAFE, :with_html_string => true}
    CheckHtmlResult.new({:body => premailer.to_inline_css, :warnings => premailer.warnings})
  end
end

class CheckHtmlResult
  attr_accessor :body
  attr_accessor :warnings
  
  def initialize options
    self.body = options[:body]
    self.warnings = options[:warnings]
  end
end
