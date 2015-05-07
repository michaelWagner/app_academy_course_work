# == Schema Information
#
# Table name: responses
#
#  id            :integer          not null, primary key
#  respondent_id :integer          not null
#  answer_id     :integer          not null
#  text          :string           not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Response < ActiveRecord::Base
  validates :respondent_id, :answer_id, :text, presence: true

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :respondent_id,
    primary_key: :id
  )

  belongs_to(
    :answer,
    class_name: "AnswerChoice",
    foreign_key: :answer_id,
    primary_key: :id
  )

  has_many(
    :sibling_responses,
    through: :answer,
    source: :responses
  )

  has_one(
    :question,
    through: :answer,
    source: :question
  )


end
