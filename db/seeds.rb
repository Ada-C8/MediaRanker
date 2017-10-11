require 'csv'

MEDIA_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw work data from #{MEDIA_FILE}"

work_failures = []
CSV.foreach(MEDIA_FILE, :headers => true) do |row|
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
puts "#{work_failures.length} works failed to save"


USER_FILE = Rails.root.join('db', 'user_seeds.csv')
puts "Loading raw user data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.name = row['name']
  puts "Created user: #{user.inspect}"
  successful = user.save
  if !successful
    user_failures << user
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"


UPVOTE_FILE = Rails.root.join('db', 'upvote_seeds.csv')
puts "Loading raw upvote data from #{UPVOTE_FILE}"

upvote_failures = []
CSV.foreach(UPVOTE_FILE, :headers => true) do |row|
  upvote = Upvote.new
  upvote.user_id = row['user_id']
  upvote.work_id = row['work_id']
  puts "Created upvote: #{upvote.inspect}"
  successful = upvote.save
  if !successful
    upvote_failures << upvote
  end
end

puts "Added #{Upvote.count} upvote records"
puts "#{upvote_failures.length} upvotes failed to save"
