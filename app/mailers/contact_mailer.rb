class ContactMailer < ApplicationMailer
  
  #お問い合わせフォーム
  
  def send_mail(contact)
    @contact = contact
    mail(:to => contact.email, :subject => 'お問い合わせ承りました')
  
  end
end
