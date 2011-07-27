class Term < ActiveRecord::Base
  belongs_to :program

  has_many :term_courses
  accepts_nested_attributes_for :term_courses

  OPEN      = 1
  CLOSED    = 2
  ENDED     = 3
  CANCELED  = 4

  STATUS = {OPEN     => 'Abierto',
            CLOSED   => 'Cerrado',
            ENDED    => 'Finalizado',
            CANCELED => 'Cancelado'}

  def status_type 
    STATUS[status]
  end

end
