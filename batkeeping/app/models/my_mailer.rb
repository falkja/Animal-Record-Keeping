class MyMailer < ActionMailer::Base

  def mail(recipient)
    from "batkeeping@pushkin.umd.edu"
    recipients recipient
    subject "Example message"
    body :account => recipient
  end

end