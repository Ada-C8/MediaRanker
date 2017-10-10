# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

WORK_FILE = Rails.root.join('db', 'seed_data', 'media_seeds.csv')
puts "Loading raw work data from #{MEDIA_FILE}"

work_failures = []
CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  work = Work.new
  work.id = row['id']
  work.name = row['name']
  work.vin = row['vin']
  puts "Created work: #{work.inspect}"
  successful = work.save
  if !successful
    work_failures << work
  end
end

puts "Added #{Work.count} driver records"
puts "#{media_failures.length} drivers failed to save"

puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
