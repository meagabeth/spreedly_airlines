# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Flight.delete_all

flights = Flight.create([
    {flight_number: 3555, origin: 'Raleigh-Durham, NC (RDU)', destination: 'Chicago, IL (ORD)', departure_time: '7:30 am', price: 7800},
    {flight_number: 4108, origin: 'Raleigh-Durham, NC (RDU)', destination: 'Washington, DC (WAS)', departure_time: '6:55 am', price: 5100},
    {flight_number: 7913, origin: 'Raleigh-Durham, NC (RDU)', destination: 'Toronto, CAN (YYZ)', departure_time: '10:25 am', price: 11200},
    {flight_number: 2605, origin: 'Raleigh-Durham, NC (RDU)', destination: 'Dallas-Fort Worth, TX (DFW)', departure_time: '1:25 pm', price: 9900},
    {flight_number: 559, origin: 'Raleigh-Durham, NC (RDU)', destination: 'San Francisco, CA (SFO)', departure_time: '9:30 pm', price: 11700},
])