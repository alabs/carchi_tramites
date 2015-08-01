class Event < ActiveRecord::Base

  has_many :inscriptions
  belongs_to :category

  validates :title, :category, presence: true

end
