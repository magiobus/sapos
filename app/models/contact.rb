class Contact < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
end
