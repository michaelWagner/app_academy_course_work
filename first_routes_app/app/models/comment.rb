class Comment < ActiveRecord::Base
  validates :commentable_id, :author_id, presence: true
  belongs_to :commentable, :polymorphic => :true
end
