class MyMailer < ActionMailer::Base

  def mail(recipient)
    from "batkeeping@pushkin.umd.edu"
    recipients recipient
    subject "Example message"
    body :account => recipient
  end
  
  def after_move(recipient, bats, new_cage, old_cage)
    from "batkeeping@pushkin.umd.edu"
    recipients recipient.email
    subject "Bats moved"
    body :account => recipient, :bats => bats, :new_cage => new_cage, :old_cage => old_cage
  end
end