# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

USER_FILE = Rails.root.join('db', 'seed_data', 'user_seeds.csv')
puts "Loading raw work data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.uid = row['uid']
  user.username = row['username']
  user.email = row['email']
  user.provider = row['provider']
  puts "Created user: #{user.inspect}"
  successful = user.save
  if !successful
    user_failures << user
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"

WORK_FILE = Rails.root.join('db', 'seed_data', 'media_seeds.csv')
puts "Loading raw work data from #{WORK_FILE}"

work_failures = []
CSV.foreach(WORK_FILE, :headers => true) do |row|
  work = Work.new
  work.id = row['id']
  work.category = row['category']
  work.title = row['title']
  work.creator = row['creator']
  work.publication_year = row['publication_year']
  work.user_id = row['user_id']
  work.description = row['description']
  puts "Created work: #{work.inspect}"
  successful = work.save
  if !successful
    puts "This did not save #{work.inspect} !!!!!!!"
    work_failures << work
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} works failed to save"

# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
