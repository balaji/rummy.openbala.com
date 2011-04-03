class IplMailer < ActionMailer::Base
  def send(request, user_name)
    recipients "balaji@openbala.com"
    subject   "Feedback from #{user_name}"
    from  "rummy@openbala.com"
    sent_on Time.now
    body  :content => mail_body(request)
  end

  private
  def mail_body(request)
    mail_content = MailBody.new
    mail_content.no = prep(request, 'no')
    mail_content.rule = prep(request, 'rule')
    mail_content.prize = prep(request, 'prizes')
    mail_content.mobile = prep(request, 'mobile')
    mail_content.laf = prep(request, 'laf')
    mail_content.more = prep(request, 'more')
    mail_content.pop = prep(request, 'pop')
    mail_content.suggest = prep(request, 'suggest')
    mail_content.feedback = prep(request, 'feedback')
    mail_content
  end

  def prep(request, param)
    if request[param] == 'on' and request['txt' + param] == ''
      'yes'
    else
      request['txt' + param]
    end
  end
end
