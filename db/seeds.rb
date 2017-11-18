 # This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = '123abc'
EVENT_TYPES = [
  'canvas',
  'slideshow',
  'phonebank',
  'meeting',
  'research',
  'other'
]

Event.destroy_all
User.destroy_all
Guest.destroy_all

super_user = User.create(
  first_name: 'Cow',
  last_name: 'Fun',
  email: 'cowfun@mail.ru',
  password: PASSWORD,
  is_admin: true
)

10.times.each do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
  )
end

users = User.all

10.times.each do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  phone_number = Faker::PhoneNumber.cell_phone
  Guest.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    phone_number: phone_number
  )
end

guests = Guest.all



10.times.each do
  start_time = Faker::Time.forward(rand(20), :morning)
  Event.create(
    event_type: EVENT_TYPES.sample,
    name: Faker::Ancient.primordial,
    location: Faker::StarTrek.location,
    description: Faker::Hacker.say_something_smart,
    date: Faker::Date.between(Date.today, 1.month.from_now),
    start_time: start_time,
    end_time: (start_time + 2.hours),
    user: users.sample
  )
end

events = Event.all

puts Cowsay.say("Created #{users.count} users", :tux)
puts Cowsay.say("Created #{events.count} events", :tux)
puts Cowsay.say("Created #{guests.count} guests", :tux)
puts "Login as admin user with #{super_user.email} and password of '#{PASSWORD}'!"
