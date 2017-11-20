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
MUNICIPALITIES = [
  'Bowen Island',
  'Burnaby',
  'Coquitlam',
  'Delta',
  'Langley',
  'Maple Ridge',
  'New Westminster',
  'North Vancouver',
  'Pitt Meadows',
  'Port Coquitlam',
  'Port Moody',
  'Richmond',
  'Surrey',
  'Vancouver',
  'West Vancouver',
  'White Rock'
]

Team.destroy_all
Event.destroy_all
User.destroy_all
Guest.destroy_all
Task.destroy_all
Membership.destroy_all


super_user = User.create(
  first_name: 'Ian',
  last_name: 'Edmonds',
  email: 'ianladneredmonds@gmail.com',
  phone_number: Faker::PhoneNumber.cell_phone,
  password: PASSWORD,
  is_admin: true
)

10.times.each do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  phone_number = Faker::PhoneNumber.cell_phone
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    phone_number: phone_number,
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
  start_time = Faker::Date.between(Date.today, 1.month.from_now)
  Event.create(
    event_type: EVENT_TYPES.sample,
    name: Faker::Ancient.primordial,
    location: MUNICIPALITIES.sample,
    description: Faker::Hacker.say_something_smart,
    date: Faker::Date.between(Date.today, 1.month.from_now),
    start_time: start_time,
    end_time: start_time,
    user: users.sample
  )
end

events = Event.all

events.each do |event|
  rand(0..5).times.each do
    Task.create(
      name: Faker::Ancient.primordial,
      description: Faker::Hacker.say_something_smart,
      user_id: users.sample.id,
      event_id: events.sample.id,
      status: Faker::Simpsons.location,
      due_by: Faker::Date.between(Date.today, 1.month.from_now),
      assigned_by: users.sample.id
    )
  end
end

tasks = Task.all

events.each do |event|
  Team.create(
    name: Faker::Ancient.god,
    event_id: event.id
  )
end

teams = Team.all

teams.each do |team|
  rand(1..10).times.each do
    Membership.create(
      user_id: users.sample.id,
      team_id: team.id
    )
  end
end

memberships = Membership.all

puts Cowsay.say("Created #{users.count} users", :tux)
puts Cowsay.say("Created #{guests.count} guests", :tux)
puts Cowsay.say("Created #{events.count} events", :tux)
puts Cowsay.say("Created #{tasks.count} tasks", :tux)
puts Cowsay.say("Created #{teams.count} teams", :tux)
puts Cowsay.say("Created #{memberships.count} memberships", :tux)
puts "Login as admin user with #{super_user.email} and password of '#{PASSWORD}'!"
