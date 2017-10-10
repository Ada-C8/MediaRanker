# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'rails'

# puts Rails.root

MEDIA_FILE = Rails.root.join('db', 'media_seeds.csv')
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

# driver_failures = []
# CSV.foreach(MEDIA_FILE, :headers => true) do |row|
#   driver = Driver.new
#   driver.id = row['id']
#   driver.name = row['name']
#   driver.vin = row['vin']
#   puts "Created driver: #{driver.inspect}"
#   successful = driver.save
#   if !successful
#     driver_failures << driver
#   end
# end
#
# puts "Added #{Driver.count} driver records"
# puts "#{driver_failures.length} drivers failed to save"
