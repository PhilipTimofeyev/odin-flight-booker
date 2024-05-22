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
	date: "2024-07-01",
	time:  "06:30",
	flight_duration: 660,
},
{
	departure_airport_id: 1,
	arrival_airport_id: 2,
	date: "2024-07-01",
	time:  "09:10",
	flight_duration: 660,
},
{
	departure_airport_id: 1,
	arrival_airport_id: 2,
	date: "2024-07-01",
	time:  "12:40",
	flight_duration: 660,
},
{
	departure_airport_id: 2,
	arrival_airport_id: 1,
	date: "2024-07-02",
	time:  "14:10",
	flight_duration: 640,
},
{
	departure_airport_id: 3,
	arrival_airport_id: 2,
	date: "2024-07-04",
	time:  "19:40",
	flight_duration: 380,
},
{
	departure_airport_id: 3,
	arrival_airport_id: 2,
	date: "2024-07-04",
	time:  "21:20",
	flight_duration: 380,
},
{
	departure_airport_id: 2,
	arrival_airport_id: 3,
	date: "2024-07-07",
	time:  "03:15",
	flight_duration: 395,
},
{
	departure_airport_id: 1,
	arrival_airport_id: 3,
	date: "2024-07-09",
	time:  "05:20",
	flight_duration: 330,
},
{
	departure_airport_id: 3,
	arrival_airport_id: 1,
	date: "2024-07-14",
	time:  "15:30",
	flight_duration: 290,
},
{
	departure_airport_id: 3,
	arrival_airport_id: 1,
	date: "2024-07-14",
	time:  "2:45",
	flight_duration: 290,
}
])

p "Created #{Airport.count} airports"
p "Created #{Flight.count} flights"