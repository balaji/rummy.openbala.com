class IplMailer < ActionMailer::Base

def send
  recipients "balaji@openbala.com"
  subject   "Feedback from"
  from  "rummy@openbala.com"
  sent_on Time.now
end

end
