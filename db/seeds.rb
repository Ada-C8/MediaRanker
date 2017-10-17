require 'csv'

MEDIA_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw work data from #{MEDIA_FILE}"

work_failures = []
CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  work = Work.new
  work.id = row['id']
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
puts "#{work_failures.length} works failed to save"

USER_FILE = Rails.root.join('db', 'user_seeds.csv')
puts "Loading raw user data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.id = row['id']
  user.username = row['username']
  puts "Created user: #{user.inspect}"
  successful = user.save
  if !successful
    user_failures << user
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"

VOTE_FILE = Rails.root.join('db', 'vote_seeds.csv')
puts "Loading raw vote data from #{USER_FILE}"

vote_failures = []
CSV.foreach(VOTE_FILE, :headers => true) do |row|
  vote = Vote.new
  vote.id = row['id']
  vote.user_id = row['user_id']
  vote.work_id = row['work_id']
  puts "Created vote: #{vote.inspect}"
  successful = vote.save
  if !successful
    vote_failures << vote
  end
end

puts "Added #{Vote.count} vote records"
puts "#{vote_failures.length} votes failed to save"

# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
