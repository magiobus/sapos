# coding: utf-8
class ScholarshipCategory < ActiveRecord::Base
  has_many :scholarship_types
  accepts_nested_attributes_for :scholarship_types
  
  validates :name, :presence => true
  
  
  
  
end
