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
  validate :respondent_has_not_already_answered_question

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



  has_one(
    :question,
    through: :answer,
    source: :question
  )

  def sister_responses
    self.question.responses.where("(:id IS NULL) OR (responses.id != :id)", id: id)
  end

  def respondent_has_not_already_answered_question
    sister_responses.each do |resp|
      if resp.respondent_id == self.respondent_id
        errors[:respondent_id] << "You have already answered the question!"
      end
    end
  end

end
