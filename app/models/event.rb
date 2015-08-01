class Event < ActiveRecord::Base
  has_many :inscriptions
  belongs_to :category
end
