# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

WORK_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw driver data from #{DRIVER_FILE}"

driver_failures = []
CSV.foreach(DRIVER_FILE, :headers => true) do |row|
  driver = Driver.new
  driver.id = row['id']
  driver.name = row['name']
  driver.vin = row['vin']
  puts "Created driver: #{driver.inspect}"
  successful = driver.save
  if !successful
    driver_failures << driver
  end
end

puts "Added #{Driver.count} driver records"
puts "#{driver_failures.length} drivers failed to save"
