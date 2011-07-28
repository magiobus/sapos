class Term < ActiveRecord::Base
  belongs_to :program

  has_many :term_course
  accepts_nested_attributes_for :term_course

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

  def assign_courses(courses)
    index = 0
    courses_in_tc = []
    params = Hash.new
    params[:term_course_attributes] = Hash.new
  
    puts courses.inspect
    self.term_course.each do |tc|
      courses_in_tc << tc.course_id
      if !courses.include?(tc.course_id) 
        params[:term_course_attributes][index] = {:id => tc.id, :status => TermCourse::UNASSIGNED}
        puts "Dar de baja #{tc.course_id}"
        index += 1
      else
        params[:term_course_attributes][index] = {:id => tc.id, :status => TermCourse::ASSIGNED}
        index += 1
      end
    end

    puts courses_in_tc.inspect
    courses.each do |c|
      if !courses_in_tc.include?(c)
        params[:term_course_attributes][index] = {:course_id => c, :status => TermCourse::ASSIGNED}
        puts "Dar de alta #{c}"
        index += 1
      end
    end

    self.update_attributes(params)

  end

end
