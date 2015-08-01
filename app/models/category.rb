class Category < ActiveRecord::Base

  has_many :events

  validates :title, presence: true

end
