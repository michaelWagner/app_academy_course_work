# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create!(email: 'example1.com')
surl1 = ShortenedUrl.create_for_user_and_long_url!(user1, 'a long string')

user2 = User.create!(email: 'example2.com')
surl2 = ShortenedUrl.create_for_user_and_long_url!(user2, 'another long string')

Visit.record_visit!(user1, surl1)
Visit.record_visit!(user1, surl1)
Visit.record_visit!(user1, surl1)

Visit.record_visit!(user2, surl1)
Visit.record_visit!(user2, surl1)
Visit.record_visit!(user2, surl1)
