# coding: utf-8
class StudentFile < ActiveRecord::Base
  mount_uploader :file, StudentFileUploader
  validates :description, :presence => true

  before_destroy :delete_linked_file

  def delete_linked_file
    self.remove_file!
  end
end
