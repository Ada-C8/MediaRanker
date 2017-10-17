# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

WORK_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw media data from #{WORK_FILE}"

work_failures = []
CSV.foreach(WORK_FILE, :headers => true) do |row|
  work = Work.new
  work.category = row['category']
  work.title = row['title']
  work.creator = row['creator']
  work.publication_year = row['publication_year']
  work.description = row['description']
  puts "Created work: #{work.inspect}"
  sucessful = work.save
  if !sucessful
    work_failures << work
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} works failed to save"


USER_FILE = Rails.root.join('db', 'user_seeds.csv')
puts "Loading raw media data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.name = row['name']
  puts "Created user: #{user.inspect}"
  sucessful = user.save
  if !sucessful
    user_failures << user
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} user failed to save"
