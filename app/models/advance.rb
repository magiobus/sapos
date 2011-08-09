# coding: utf-8
class Advance < ActiveRecord::Base
  default_scope :order => 'advance_date DESC'
end
