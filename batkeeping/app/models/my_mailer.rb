class MyMailer < ActionMailer::Base

  def mail(recipient)
    from "ben@pushkin.umd.edu"
    recipients recipient
    subject "Example message"
    body :account => recipient
  end

end