# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

WORK_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw works data from #{WORK_FILE}"

work_failures = []
CSV.foreach(WORK_FILE, :headers => true) do |row|
  work = Work.new
  work.category = row['category']
  work.title = row['title']
  work.creator = row['creator']
  work.publication_year = row['publication_year']
  work.description = row['description']
  puts "Created work: #{work.inspect}"
  successful = work.save
  if !successful
    work_failures << work
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} work failed to save"


#add some users
user_failures = []
20.times do |i|
  user = User.new name: "user number #{i}"
  puts "Created user: #{user.inspect}"
  successful = user.save
  if !successful
    user_failures << user
  end
end
puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"

#add some votes
vote_failures =[]
40.times do
  vote = Vote.create user_id: rand(20), work_id: rand(15)
  puts "Created vote: #{vote.inspect}"
  successful = vote.save
  if !successful
    vote_failures << vote
  end
end
puts "Added #{Vote.count} vote records"
puts "#{vote_failures.length} votes failed to save"
puts "done"
