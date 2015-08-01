class InscriptionsController < InheritedResources::Base
  actions :new, :create

  def new
    @event = Event.find(params[:event_id] || 1)
    new!
  end

  def create
    create!(:notice => "Te has dado de alta en el curso. Revisaremos tu inscripción y te avisaremos el resultado dentro de unos días.") { root_url }
  end

  private

  def inscription_params
    params.require(:inscription).permit(:event_id, :first_name, :last_name, :phone, :email)
  end
end

