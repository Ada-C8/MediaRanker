require 'csv'
require 'rails'

puts Rails.root

DRIVER_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw driver data from #{DRIVER_FILE}"

driver_failures = []
CSV.foreach(DRIVER_FILE, :headers => true) do |row|
    record = Work.new
    record.id = row['id']
    record.category = row['category']
    record.title = row['title']
    record.creator = row['creator']
    record.published = row['published']
    puts "Created Album: #{record.inspect}"
    successful = record.save
    if !successful
      driver_failures << record
    end
end

puts "Added #{Work.count} driver records"
puts "#{driver_failures.length} drivers failed to save"
