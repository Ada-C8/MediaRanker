require 'csv'

WORKS_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw media data from #{WORKS_FILE}"

works_failures = []
CSV.foreach(WORKS_FILE, :headers => true) do |row|
  work = Work.new
  work.category = row['category']
  work.title = row['title']
  work.creator = row['creator']
  work.publication_year = row['publication_year']
  work.description = row ['description']
  puts "Created work: #{work.inspect}"
  successful = work.save
  if !successful
    works_failures << work
  end
end

puts "Added #{Work.count} work records"
puts "#{works_failures.length} works failed to save"

# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
