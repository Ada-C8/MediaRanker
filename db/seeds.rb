require 'csv'
require 'rails'
require 'date'

puts Rails.root

USER_FILE = Rails.root.join('db', 'users_seed.csv')
user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
    user = User.new
    user.id = row['id']
    user.name = row['name']
    user.joined_on = Date.today
    puts "Created Album: #{user.inspect}"
    successful = user.save
    if !successful
      user_failures << user
    end
end

DRIVER_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw driver data from #{DRIVER_FILE}"

driver_failures = []
CSV.foreach(DRIVER_FILE, :headers => true) do |row|
    record = Work.new
    record.id = row['id']
    record.category = row['category']
    record.title = row['title']
    record.creator = row['creator']
    record.published = row['publication_year']
    record.description = row['description']
    puts "Created Album: #{record.inspect}"
    successful = record.save
    if !successful
      driver_failures << record
    end
end


VOTE_FILE = Rails.root.join('db', 'vote_seed.csv')
vote_failures = []
CSV.foreach(VOTE_FILE, :headers => true) do |row|
    vote = Vote.new
    vote.id = row['id']
    vote.category = row['category']
    vote.work_id = row['work_id']
    vote.user_id = row['user_id']
    vote.date = Date.today
    puts "Created Album: #{vote.inspect}"
    successful = vote.save
    if !successful
      vote_failures << vote
    end
end
