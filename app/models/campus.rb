class Campus < ActiveRecord::Base
  has_many :students, :order => "first_name, last_name"

  has_one :contact, :as => :attachable
  accepts_nested_attributes_for :contact

  validates :name, :presence => true
  validates :short_name, :presence => true

  after_create :add_extra

  mount_uploader :image, CampusImageUploader

  def full_name
    "#{name} (#{short_name})" rescue ''
  end

  def add_extra
    self.build_contact()
    self.save(:validate => false)
  end

end
