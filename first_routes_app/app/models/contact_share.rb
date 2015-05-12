class ContactShare < ActiveRecord::Base
  validates :contact_id, :user_id, presence: true, uniqueness: true
  belongs_to :contact
  belongs_to :user
  has_many :comments

end
