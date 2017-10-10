require 'csv'

MEDIA_FILE = Rails.root.join('db', 'media_seeds.csv')
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

puts "Added #{Work.count} driver records"
puts "#{work_failures.length} drivers failed to save"

puts "done"
