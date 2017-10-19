# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
authors = %w(Kitty, Finn, Girlie, Suge, Sara, Jamey)

users = %w(burger taco spaghetti padthai mayonnaise tuna sardine tofu ramen hotdog rice eggroll hotpot burrito steak)
users.each do |username|
  User.create(username: username)
end

30.times do |n|
  Work.create([{title: "Book #{n}", creator: authors.sample, publication_year: 2017, description: "Description for Book #{n}", category: 'book'}])
end
30.times do |n|
  Work.create([{title: "Movie #{n}", creator: authors.sample, publication_year: 2010, description: "Description for Movie #{n}", category: 'movie'}])
end
30.times do |n|
  Work.create([{title: "Album #{n}", creator: authors.sample, publication_year: 2001, description: "Description for Album #{n}", category: 'album'}])
end

Work.all.each do |work|
  User.all.each do |user|
    if [true, false].sample
      Vote.create(user: user, work: work)
    end
  end
end
