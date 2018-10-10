class ApplicationMailer < ActionMailer::Base
  layout 'mailer'
  append_view_path Rails.root.join('app/views/mailers')
end
