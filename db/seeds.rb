# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

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
  work.description = row['description']
  puts "Created work: #{work.inspect}"
  successful = work.save
  if !successful
    work_failures << work
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} works failed to save"

#
#
# PASSENGER_FILE = Rails.root.join('db', 'seed_data', 'passengers.csv')
# puts "Loading raw passenger data from #{PASSENGER_FILE}"
#
# passenger_failures = []
# CSV.foreach(PASSENGER_FILE, :headers => true) do |row|
#   passenger = Passenger.new
#   passenger.id = row['id']
#   passenger.name = row['name']
#   passenger.phone_num = row['phone_num']
#   puts "Created passenger: #{passenger.inspect}"
#   successful = passenger.save
#   if !successful
#     passenger_failures << passenger
#   end
# end
#
# puts "Added #{Passenger.count} passenger records"
# puts "#{passenger_failures.length} passengers failed to save"
#
#
#
# TRIP_FILE = Rails.root.join('db', 'seed_data', 'trips.csv')
# puts "Loading raw trip data from #{TRIP_FILE}"
#
# trip_failures = []
# CSV.foreach(TRIP_FILE, :headers => true) do |row|
#   trip = Trip.new
#   trip.id = row['id']
#   trip.driver_id = row['driver_id']
#   trip.passenger_id = row['passenger_id']
#   trip.date = Date.strptime(row['date'], '%Y-%m-%d')
#   trip.rating = row['rating']
#   trip.cost = row['cost']
#   puts "Created trip: #{trip.inspect}"
#   successful = trip.save
#   if !successful
#     trip_failures << trip
#   end
# end
#
# puts "Added #{Trip.count} trip records"
# puts "#{trip_failures.length} trips failed to save"


# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
