# coding: utf-8
class Student < ActiveRecord::Base

  belongs_to :program
  belongs_to :campus

  has_one :state
  has_one :country

  has_one :contact, :as => :attachable
  accepts_nested_attributes_for :contact

  has_one :scholarship
  accepts_nested_attributes_for :scholarship

  has_one :thesis
  accepts_nested_attributes_for :thesis

  has_many :advance
  accepts_nested_attributes_for :advance

  has_many :student_file
  accepts_nested_attributes_for :student_file

  has_many :term_students
  accepts_nested_attributes_for :term_students

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :program_id, :presence => true  
  # validates :email, :uniqueness => true, :email_format => true, :on => :update
  
  after_create :set_card, :add_extra

  mount_uploader :image, StudentImageUploader

  ACTIVE    = 1
  GRADUATED = 2
  INACTIVE  = 3

  STATUS = {ACTIVE    => 'Activo',
            GRADUATED => 'Graduado',
            INACTIVE  => 'Baja'}

  def status_type
    STATUS[status]
  end
  
  def set_card
    # Update card with format: PPPYYMM999
    # Where:
    #   PPPP is program prefix 
    #   YY Last 2 digits of Year start date
    #   MM Month number of start date
    #   999 Consecutive lead zero
    con = Student.where(:program_id => self.program_id).where("start_date between ? and ?",start_date.strftime('%Y-01-01') ,start_date.strftime('%Y-12-31')).maximum('consecutive')
    if con.nil?
      con = 1
    else 
      con += 1
    end
    consecutive = "%03d" % con
    self.consecutive = con
    self.card = "#{self.program.prefix}#{self.start_date.strftime('%y%m')}#{consecutive}" 
    self.save(:validate => false)
  end
  
  def add_extra
    self.build_contact()
    self.build_scholarship()
    self.build_thesis()
    self.save(:validate => false)
  end

  def set_nest(item)
    item.student ||= self
  end

  def full_name
    "#{first_name} #{last_name}" rescue ''
  end

  def full_name_with_card
    "#{card}: #{first_name} #{last_name}" rescue ''
  end

end
