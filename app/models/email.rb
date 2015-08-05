class Email < ActiveRecord::Base

  belongs_to :category

  TYPE = {
    "new" => 0,
    "approved" => 1,
    "denied" => 2,
  }

  def ttype_name
    Email::TYPE.invert[self.ttype]
  end

end