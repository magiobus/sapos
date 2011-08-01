class ScholarshipCategory < ActiveRecord::Base
  has_many :scholarship_types
end
