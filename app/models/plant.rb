class Plant < ActiveRecord::Base

  has_many :inscriptions_plants

  validates :name, presence: true

end
