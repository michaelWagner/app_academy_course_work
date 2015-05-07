# == Schema Information
#
# Table name: visits
#
#  id               :integer          not null, primary key
#  visitor_id       :integer
#  shortened_url_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Visit < ActiveRecord::Base
  validates :visitor_id, :shortened_url_id, presence: true

  belongs_to(
    :shortened_url,
    class_name: "ShortnedUrl",
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  belongs_to(
    :visitor,
    class_name: "User",
    foreign_key: :visitor_id,
    primary_key: :id
  )

  def self.record_visit!(user, shortened_url)
    create!(visitor_id: user.id, shortened_url_id: shortened_url.id)
  end
end
