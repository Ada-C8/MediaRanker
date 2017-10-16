# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'rails'

puts Rails.root

MEDIA_FILE = Rails.root.join('db', 'seed_data', 'media_seeds.csv')
# what is this doing and why does it need to happen?
puts "Loading raw driver data from #{MEDIA_FILE}"

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

# ____________________________________________________


# USER_FILE = Rails.root.join('db', 'seed_data', 'user_seeds.csv')
# puts "Loading raw user data from #{USER_FILE}"
#
# user_failures = []
#
# CSV.foreach(USER_FILE, :headers => true) do |row|
#   user = User.new
#   user.name = row['name']
#   puts "Created user: #{user.inspect}"
#   successful = user.save
#   if !successful
#     user_failures << user
#   end
# end
#
# puts "Added #{User.count} user records"
# puts "#{user_failures.length} users failed to save"




# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
# puts "Manually resetting PK sequence on each table"
# ActiveRecord::Base.connection.tables.each do |t|
#   ActiveRecord::Base.connection.reset_pk_sequence!(t)
# end
#
# puts "done"
