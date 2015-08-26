class InscriptionMailer < ApplicationMailer

  default from: Rails.application.secrets.email["default_from"]

  def pending inscription_id
    InscriptionMailer.pending_admin(inscription_id).deliver_now
    send_inscription_email(inscription_id, 0)
  end

  def pending_admin inscription_id
    @inscription = Inscription.find inscription_id
    mail to: @inscription.event.category.admin_email.split(','), subject: "[carchi] Inscripción pendiente en #{@inscription.event.title}"
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
