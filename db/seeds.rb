# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

CAT_FILE = Rails.root.join('db', 'category_seeds.csv')
puts "==== Loading category data from #{CAT_FILE} ===="

cat_failures = []
CSV.foreach(CAT_FILE, :headers => true) do |row|
  cat = Category.new
  cat.id = row['id']
  cat.name = row['cat']

  puts "Created category: #{cat.inspect}"
  successful = cat.save

  if !successful
    cat_failures << cat
  end
end

puts "Added #{Category.count} category recsords"
puts "#{cat_failures.length} categories failed to save"


MEDIA_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "\n==== Loading media sample data from #{MEDIA_FILE} ===="

work_failures = []
CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  work = Work.new
  work.category_id = row['category_id']
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

puts "Added #{Work.count} media records"
puts "#{work_failures.length} works failed to save"

# reset pk sequence for category table ONLY
ActiveRecord::Base.connection.reset_pk_sequence!('categories')


USER_FILE = Rails.root.join('db', 'user_seeds.csv')
puts "\n==== Loading user sample data from #{USER_FILE} ===="

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


VOTE_FILE = Rails.root.join('db', 'vote_seeds.csv')
puts "\n==== Loading vote sample data from #{VOTE_FILE} ===="

vote_failures = []
CSV.foreach(VOTE_FILE, :headers => true) do |row|
  vote = Vote.new
  vote.work_id = row['work_id']
  vote.user_id = row['user_id']

  puts "Created vote: #{vote.inspect}"
  successful = vote.save

  if !successful
    vote_failures << vote
  end
end

puts "Added #{Vote.count} vote records"
puts "#{vote_failures.length} votes failed to save"
