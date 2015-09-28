namespace :carchi do 
  namespace :google_calendar do
    desc "[carchi] Consigue el refresh_token inicial."
    task :refresh_token do 
      cal = Google::Calendar.new(
        :client_id     => Rails.application.secrets.google_calendar["client_id"],
        :client_secret => Rails.application.secrets.google_calendar["secret_key"],
        :calendar      => Rails.application.secrets.google_calendar["calendar_id"],
        :redirect_url  => "urn:ietf:wg:oauth:2.0:oob"
      )
      # A user needs to approve access in order to work with their calendars.
      puts "Visita la siguiente web para aprobar el acceso."
      puts cal.authorize_url
      puts "\nCopia el codigo que Google devuelve y pegalo aqui"
      # Pass the ONE TIME USE access code here to login and get a refresh token that you can use for access from now on.
      refresh_token = cal.login_with_auth_code( $stdin.gets.chomp )
      puts "Guarda el google_calendar[:refresh_token] en config/secrets.yml:\n\t#{refresh_token}\n"
    end
  end
end
