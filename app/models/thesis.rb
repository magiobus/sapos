class Thesis < ActiveRecord::Base
  belongs_to :student

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

end
