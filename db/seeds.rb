# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'csv'

USER_FILE = Rails.root.join('db', 'seed_data', 'users_seeds.csv')
puts "Loading raw user data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.id = row['id']
  user.username = row['username']
  user.date_joined = (Date.today-rand(100)).strftime('%Y-%m-%d')
  puts "Created user: #{user.inspect}"
  successful = user.save
  if !successful
    user_failures << user
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"



MEDIA_FILE = Rails.root.join('db', 'seed_data', 'media_seeds.csv')
puts "Loading raw media data from #{MEDIA_FILE}"

media_failures = []
CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  media = Work.new
  media.id = row['id']
  media.category = row['category']
  media.title = row['title']
  media.creator = row['creator']
  media.publication_year = row['publication_year']
  media.description = row['description']
  puts "Created media: #{media.inspect}"
  successful = media.save
  if !successful
    media_failures << media
  end
end

puts "Added #{Work.count} media records"
puts "#{media_failures.length} media failed to save"



VOTE_FILE = Rails.root.join('db', 'seed_data', 'votes_seeds.csv')
puts "Loading raw trip data from #{VOTE_FILE}"

vote_failures = []
CSV.foreach(VOTE_FILE, :headers => true) do |row|
  vote = Vote.new
  vote.id = row['id']
  vote.user_id = row['user_id']
  vote.work_id = row['work_id']
  vote.date =(Date.today-rand(100)).strftime('%Y-%m-%d')
  puts "Created vote: #{vote.inspect}"
  successful = vote.save
  if !successful
    vote_failures << vote
  end
end

puts "Added #{Vote.count} vote records"
puts "#{vote_failures.length} vote failed to save"


# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
