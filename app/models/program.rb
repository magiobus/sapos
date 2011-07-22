class Program < ActiveRecord::Base
  has_many :students
  validates :name, :presence => true
  validates :prefix, :presence => true
end
