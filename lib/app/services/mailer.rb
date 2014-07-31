class Mailer
  def self.mail_from_params(params)
    mail(to: 'tyrbo.a+hapa@gmail.com',
       from: params[:email],
    subject: 'Contact Form',
       body: "#{params[:contactName]} wrote:\n\n#{params[:comments]}")
  end

  def self.mail(from:, to:, subject:, body:)
    mail = Mail.new
    mail.to to
    mail.from from
    mail.subject subject
    mail.body body
    mail.deliver!
  end
end
