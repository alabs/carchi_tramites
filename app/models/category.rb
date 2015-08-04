class Category < ActiveRecord::Base

  has_many :events
  has_many :emails

  validates :title, presence: true

end
