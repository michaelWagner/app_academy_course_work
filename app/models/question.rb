# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  poll_id    :integer          not null
#  text       :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :poll_id, :text, presence: true

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answers,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answers,
    source: :responses
  )

  def results

    answers
      .select("answer_choices.*, COUNT(responses.answer_id) AS count")
      .joins("JOIN responses ON responses.answer_id = answer_choices.id")
      .joins("LEFT OUTER JOIN questions ON answer_choices.question_id = questions.id")
      .where("questions.id = ?", self.id)
      .group("answer_choices.id")

    # SELECT
    #   answer_choices.*, COUNT(responses.answer_id)
    # FROM
    #   answer_choices
    # JOIN
    #   responses ON responses.answer_id = answer_choices.id
    # JOIN
    #   questions ON answer_choices.question_id = questions.id
    # WHERE
    #   questions.id = self.id
    # GROUP BY
    #   answer_choices.id

  end

end
