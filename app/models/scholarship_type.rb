# coding: utf-8
class ScholarshipType < ActiveRecord::Base
  has_many :scholarship
  belongs_to :scholarship_category
end
