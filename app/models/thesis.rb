# coding: utf-8
class Thesis < ActiveRecord::Base
  belongs_to :student
  after_update :set_student_status

  CONCLUDED   = 'C'
  IN_PROGRESS = 'P'
  INACTIVE    = 'I'

  STATUS = {CONCLUDED   => 'Concluida',
            IN_PROGRESS => 'En progreso',
            INACTIVE    => 'Inactiva'}

  def status_type
    STATUS[status]
  end

  def set_number
    #TODO Add validations
    # Set thesis number with format: PPPP999
    # Where:
    #   PPPP is program prefix 
    #   999  Consecutive lead zero

    con = Thesis.where("number LIKE ?",self.student.program.prefix + "%").maximum('consecutive')
    if con.nil?
      con = 1
    else
      con += 1
    end

    consecutive = "%03d" % con

    self.consecutive = con
    self.number = "#{self.student.program.prefix}#{consecutive}"
    self.save
  end

  def set_student_status
    if self.status == CONCLUDED
      s = Student.find(self.student_id)
      s.end_date = self.defence_date
      s.status = Student::GRADUATED
      s.save
    end
  end

end
