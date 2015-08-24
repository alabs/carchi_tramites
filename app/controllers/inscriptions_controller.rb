class InscriptionsController < ApplicationController
  
  def new
    @event = Event.find(params[:event_id] || 1)
    @inscription = Inscription.new
  end  
    
  def create
    @inscription = Inscription.new(inscription_params)
    @event = Event.find(inscription_params[:event_id])
    if @inscription.save
      InscriptionMailer.pending(@inscription.id).deliver_now
      flash[:notice] = "Te has dado de alta en el curso. Revisaremos tu inscripción y te avisaremos el resultado dentro de unos días."
      redirect_to root_url
    else  
      render :action => 'new'
    end  
  end  

  private

  def inscription_params
    params.require(:inscription).permit(:event_id, :first_name, :last_name, :phone, :email, :document_id, :sex, :born_at, :address, :parroquia, :canton, :provincia)
  end

end
