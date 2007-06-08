class MyMailer < ActionMailer::Base

  def mail(recipient, msg_subject, msg_body)
    from "batkeeping@pushkin.umd.edu"
    recipients recipient.email
    subject msg_subject
    body :email_body => msg_body
  end
  
  def mass_mail(recipients, msg_subject, msg_body)
    from "batkeeping@pushkin.umd.edu"
    recipients recipients
    subject msg_subject
    body :email_body => msg_body
  end
end