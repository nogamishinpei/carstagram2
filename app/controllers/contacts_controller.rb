class ContactsController < ApplicationController
  
  def new
    @contact = Contact.new
  end
  
  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      render :new
    end
  end
  
  #入力に誤りがあった場合に入力を保持したまま前ページに戻るため
  #backアクションを定義してます。
  def back
    @contact = Contact.new(contact_params)
    render :new
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to done_path
    else
      render :new
    end
  end
  
  #送信完了画面用
  def done
  end
  
private

def contact_params
  params.require(:contact).permit(:email, :name, :phone_number, :subject, :message)
  
end
end