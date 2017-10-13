require 'csv'
require 'rails'

puts Rails.root

DRIVER_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw driver data from #{DRIVER_FILE}"

driver_failures = []
CSV.foreach(DRIVER_FILE, :headers => true) do |row|
  if row['category'] == 'album'
    record = Album.new
    record.id = row['id']
    record.title = row['title']
    record.creator = row['creator']
    record.published = row['published']
    puts "Created Album: #{record.inspect}"
    successful = record.save
    if !successful
      driver_failures << record
    end
  else
    record = Book.new
    record.id = row['id']
    record.title = row['title']
    record.creator = row['creator']
    record.published = row['published']
    puts "Created Album: #{record.inspect}"
    successful = record.save
    if !successful
      driver_failures << record
    end
  end

end

puts "Added #{Driver.count} driver records"
puts "#{driver_failures.length} drivers failed to save"
