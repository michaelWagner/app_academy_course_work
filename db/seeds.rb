# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



User.create!(user_name: "asdfasdf")
User.create!(user_name: "fdsafdsa")
Poll.create!(title: "hello", author_id: 1 )
Poll.create!(title: "hello", author_id: 1 )
Poll.create!(title: "hello", author_id: 1 )
Poll.create!(title: "hello", author_id: 1 )
Question.create!(poll_id: 1, text: "what")
Question.create!(poll_id: 1, text: "who")
Question.create!(poll_id: 1, text: "when")
Question.create!(poll_id: 1, text: "where")
Question.create!(poll_id: 1, text: "how")
AnswerChoice.create!(question_id: 1, text: "a")
AnswerChoice.create!(question_id: 1, text: "b")
AnswerChoice.create!(question_id: 1, text: "c")
AnswerChoice.create!(question_id: 2, text: "a")
AnswerChoice.create!(question_id: 2, text: "b")
AnswerChoice.create!(question_id: 2, text: "c")
Response.create!(respondent_id: 1, answer_id: 1, text: "asdfasdffds")
Response.create!(respondent_id: 1, answer_id: 2, text: "wwwwwww")
Response.create!(respondent_id: 2, answer_id: 3, text: "ddddddddd")
Response.create!(respondent_id: 2, answer_id: 4, text: "jjjjjjjjjjj")
