class AdminUser < ActiveRecord::Base

  include FlagShihTzu

  has_flags 1 => :actividad,
    2 => :audiencia,
    3 => :plantas,
    4 => :admin,
    :column => "roles"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
    :recoverable, :rememberable, :trackable, :validatable

  validates :email, uniqueness: true

  def is? role
    case role
    when :admin then self.admin?
    when :audiencia then self.audiencia?
    when :actividad then self.actividad?
    when :plantas then self.plantas?
    else false
    end
  end

  # http://arp242.net/weblog/making_flag_shih_tzu_work_well_with_formtastic.html
  def roles_array= val
    self.roles =
      if val.respond_to?(:reduce)
        val.reduce(0) { |memo, n| memo + n.to_i }
      else
        val
      end
  end

  # http://arp242.net/weblog/making_flag_shih_tzu_work_well_with_formtastic.html
  def roles_array
    roles.to_s(2).split('').reverse
    .map.with_index { |bit, i| 2 ** i if bit == '1' }
    .compact
  end

end
