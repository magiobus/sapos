class Program < ActiveRecord::Base
  MASTER        = 1
  DOCTORATE     = 2
  PROPADEUTIC   = 3
  POSTDOCTORATE = 4
  DIPLOMA       = 5

  SEMESTER      = 1
  QUADMESTER    = 2
  TRIMESTER     = 3
  
  LEVEL = {POSTDOCTORATE => 'Postdoctorado',
           DOCTORATE     => 'Doctorado',
           MASTER        => 'Maestría',
           PROPADEUTIC   => 'Propedéutico',
           DIPLOMA       => 'Diplomado'}

  TERM = {TRIMESTER  => 'Trimestre',
          QUADMESTER => 'Cuatrimestre',
          SEMESTER   => 'Semestre'}

  has_many :students

  has_many :courses
  accepts_nested_attributes_for :courses

  has_many :terms
  accepts_nested_attributes_for :terms

  validates :name, :presence => true
  validates :prefix, :presence => true
  validates :level, :presence => true

  def level_type
    LEVEL[level]
  end

  def term_type
    TERM[terms_duration]
  end
end
