class InscriptionMailer < ApplicationMailer

  def new inscription
    @inscription = Inscription.find inscription
    mail to: inscription.email
  end

  def approved inscription
    @inscription = Inscription.find inscription
    mail to: inscription.email
  end

  def denied inscription
    @inscription = Inscription.find inscription
    mail to: inscription.email
  end

end
