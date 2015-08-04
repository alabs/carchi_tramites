class InscriptionMailer < ApplicationMailer

  def pending inscription_id
    send_inscription_email(inscription_id, 0)
  end

  def approved inscription_id
    send_inscription_email(inscription_id, 1)
  end

  def denied inscription_id
    send_inscription_email(inscription_id, 2)
  end

  private 

  def send_inscription_email(inscription_id, ttype)
    @inscription = Inscription.find inscription_id
    @email = @inscription.event.category.emails.find_by_ttype ttype 
    #debugger if @email.nil?
    mail to: @inscription.email, subject: @email.subject
  end

end
