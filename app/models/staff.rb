class Staff < ActiveRecord::Base
  belongs_to :institution
  has_many :term_course_schedule

  has_one :contact, :as => :attachable
  accepts_nested_attributes_for :contact

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  
  after_create :add_extra

  mount_uploader :image, StaffImageUploader

  def full_name
    "#{first_name} #{last_name}" rescue ''
  end
  
  def add_extra
    self.build_contact()
    self.save(:validate => false)
  end

end
