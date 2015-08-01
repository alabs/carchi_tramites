class InscriptionMailer < ApplicationMailer

  def new inscription_id
    @inscription = Inscription.find inscription_id
    mail to: @inscription.email
  end

  def approved inscription_id
    @inscription = Inscription.find inscription_id
    mail to: @inscription.email
  end

  def denied inscription_id
    @inscription = Inscription.find inscription_id
    mail to: @inscription.email
  end

end
