# Preview all emails at http://localhost:3000/rails/mailers/inscription_mailer
class InscriptionMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/inscription_mailer/new
  def new
    InscriptionMailer.new
  end

  # Preview this email at http://localhost:3000/rails/mailers/inscription_mailer/approved
  def approved
    InscriptionMailer.approved
  end

  # Preview this email at http://localhost:3000/rails/mailers/inscription_mailer/denied
  def denied
    InscriptionMailer.denied
  end

end
