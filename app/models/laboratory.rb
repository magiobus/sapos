class Laboratory < ActiveRecord::Base
  belongs_to :campus

  validates :name, :presence => true
  validates :code, :presence => true

  def full_name
    "#{code}: #{name}" rescue name
  end

end
