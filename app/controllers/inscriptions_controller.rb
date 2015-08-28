class InscriptionsController < ApplicationController
    
  def new
    @event = Event.friendly.find(params[:event_id] || 1)
    @inscription = Inscription.new
    @inscription.inscriptions_plants.build
  end  
    
  def create
    @inscription = Inscription.new(inscription_params)
    @event = Event.friendly.find(inscription_params[:event_id])
    if @inscription.save
      InscriptionMailer.pending(@inscription.id).deliver_now
      flash[:notice] = "Revisaremos tu inscripción y te avisaremos el resultado dentro de unos días."
      redirect_to root_url
    else  
      render :action => 'new'
    end  
  end  

  private

  def inscription_params
    params.require(:inscription).permit(:event_id, :first_name, :last_name, :phone, 
      :email, :document_id, :sex, :born_at, :address, :parroquia, :canton, :provincia,
      :ed_level, :ed_unity, :observations, :rep_document_id, :rep_full_name, :rep_sex, 
      :rep_title, :rep_phone_home, :rep_phone_celular, :rep_parroquia, :rep_canton, 
      :rep_provincia, :rep_address, :rep_work_name, :rep_work_address, :rep_work_phone, 
      :motive, :appointed_at, :plant_location, :plant_representation, inscriptions_plants_attributes: 
      [:id, :plant_id, :inscription_id, :quantity, :_destroy])
  end

end
