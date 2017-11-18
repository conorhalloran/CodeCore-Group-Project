PASSWORD = '123abc'
EVENT_TYPES = [
  'canvas',
  'slideshow',
  'phonebank',
  'meeting',
  'research',
  'other'
]


User.destroy_all

super_user = User.create(
  first_name: 'Cow',
  last_name: 'Fun',
  email: 'cowfun@mail.ru',
  password: PASSWORD
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
