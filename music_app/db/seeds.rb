# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(email: "mikey@mikey", password: "mikeymikey")

Band.create!(name: "rockerz")
Band.create!(name: "acdc")
Band.create!(name: "beatles")
Band.create!(name: "kinks")

Album.create!(title: "hurtz so good", band_id: 1)
Album.create!(title: "back in black", band_id: 2)
Album.create!(title: "revolver", band_id: 3)
Album.create!(title: "white album", band_id: 3)
Album.create!(title: "rubber soul", band_id: 3)
Album.create!(title: "something else", band_id: 4)

Track.create!(album_id: 1, song_name: "the strain")
Track.create!(album_id: 5, song_name: "drive my car")
Track.create!(album_id: 4, song_name: "helter skelter")
Track.create!(album_id: 3, song_name: "tax man")
Track.create!(album_id: 6, song_name: "autumn almanac")
