module InscriptionsHelper

  def get_locations(type, prefix)
    # :parroquias, "ins"
    # :parroquias, "rep"
    Rails.cache.fetch("locations__#{prefix}_#{type}") do 
      result = File.open("db/geo/ecuador_#{type}.csv").read().split(/\n/)
      result = result.map { |n| n.split(',') }
      case type
      when :provincias
        result = result.map {|n| [ n[1], "c_#{prefix}provincia_#{n[0]}" ] }
      when :cantones
        result = result.map {|n| [ n[2], "c_#{prefix}canton_#{n[0]}_#{n[1]}", {'class': "sub_c_#{prefix}provincia_#{n[0]}"} ] }
      when :parroquias
        result = result.map {|n| [ n[3], "c_#{prefix}parroquia_#{n[0]}_#{n[1]}_#{n[2]}", {'class': "sub_c_#{prefix}canton_#{n[0]}_#{n[1]}"} ] }
      end
      { as: :select, collection: result }
    end
  end

end
