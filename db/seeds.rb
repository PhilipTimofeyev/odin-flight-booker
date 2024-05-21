# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Airport.destroy_all
Flight.destroy_all

Airport.create!([{
	code: "LAX"
},
{
	code: "LHR"
},
{
	code: "JFK"
}
])

Flight.create!([{
	departure_airport_id: 1,
	arrival_airport_id: 2,
},
{
	departure_airport_id: 2,
	arrival_airport_id: 1,
},
{
	departure_airport_id: 3,
	arrival_airport_id: 2,
},
{
	departure_airport_id: 2,
	arrival_airport_id: 3,
},
{
	departure_airport_id: 1,
	arrival_airport_id: 3,
},
{
	departure_airport_id: 3,
	arrival_airport_id: 1,
}
])

p "Created #{Airport.count} airports"
p "Created #{Flight.count} flights"