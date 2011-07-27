class Course < ActiveRecord::Base
  belongs_to :program

  has_many :term_courses
  accepts_nested_attributes_for :term_courses



  def full_name
    "#{code}: #{name}" rescue name
  end
end
