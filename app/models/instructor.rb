class Instructor < ActiveRecord::Base
  belongs_to :event

  def sex_name
    Inscription::SEX.invert[self.sex]
  end

end
