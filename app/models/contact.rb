# coding: utf-8
class Contact < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
end
