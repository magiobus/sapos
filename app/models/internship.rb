class Internship < ActiveRecord::Base
  belongs_to :institution

  has_one :contact, :as => :attachable
  accepts_nested_attributes_for :contact

  has_many :internship_file
  accepts_nested_attributes_for :internship_file

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :institution_id, :presence => true
  validates :internship_type_id, :presence => true

  after_create :add_extra

  mount_uploader :image, InternshipImageUploader

  ACTIVE    = 0
  FINISHED  = 1
  INACTIVE  = 2

  STATUS = {ACTIVE    => 'Activo',
            FINISHED  => 'Finalizado',
            INACTIVE  => 'Inactivo'}


  def full_name
    "#{first_name} #{last_name}" rescue ''
  end

  def add_extra
    self.build_contact()
    self.save(:validate => false)
  end


end
