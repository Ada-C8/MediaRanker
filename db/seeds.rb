# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

MEDIA_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading your raw media data from #{MEDIA_FILE}"


work_failures = []
CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  work = Work.new
  work.category = row['category']
  work.title = row['title']
  work.creator = row['creator']
  work.year = row['publication_year']
  work.description = row['description']
  successful = work.save
  if !successful
    work_failures << work
  end
  puts "Created work: #{work.inspect}"
end


puts "Added #{Work.count} work records"

puts "#{work_failures.length} works failed to load"

puts "done"




USER_FILE = Rails.root.join('db', 'user_seeds.csv')
puts "Loading your raw media data from #{USER_FILE}"


user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.name = row['name']
  successful = user.save
  if !successful
    user_failures << user
  end
  puts "Created user: #{user.inspect}"
end


puts "Added #{User.count} work records"
puts "#{user_failures.length} works failed to load"


VOTE_FILE = Rails.root.join('db', 'vote_seeds.csv')
puts "Loading your raw media data from #{VOTE_FILE}"

vote_failures = []
CSV.foreach(VOTE_FILE, :headers => true) do |row|
  vote = Vote.new
  vote.user_id = row['user_id']
  vote.work_id = row['work_id']
  successful = vote.save
  if !successful
    vote_failures << vote
  end
  puts "Created work: #{vote.inspect}"
end


puts "Added #{Vote.count} work records"
puts "#{vote_failures.length} works failed to load"

puts "done"
