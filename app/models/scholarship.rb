class Scholarship < ActiveRecord::Base
  belongs_to :student
  belongs_to :scholarship_type
end
