namespace :carchi do 
  namespace :events do

    desc "Comprueba los límites de los eventos y envía correos si se llegan a los mismos."
    task check_limits: :environment do 
      Event.where.not(limit: nil).each do |event|
        if event.has_reached_limit?
          EventsMailer.limit_reached(event.id).deliver_now
        end
      end

    end

  end
end
