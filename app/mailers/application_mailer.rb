class ApplicationMailer < ActionMailer::Base
  default from: 'dkim.steve@gmail.com'
  layout 'mailer'
end
