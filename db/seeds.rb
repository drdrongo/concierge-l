# ------------------------ Universal / User methods ------------------------

# Method that clears Database
def destroy_everything
  Event.destroy_all
  Hotel.destroy_all
  Amenity.destroy_all
  Article.destroy_all
  User.destroy_all
end

# Method that creates a user
def create_user
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: 'secret',
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    birthday: rand(52.years.ago .. 20.years.ago)
  )
  # file = URI.open("https://i.pravatar.cc/200")
  # user.photo.attach(io: file, filename: "#{user.first_name}_#{user.last_name}.png", content_type: 'image/png')
  user.save
  return user
end

# Method that creates an admin user
def create_admin(first_name:, last_name:, email:)
  admin = create_user
  admin.update(
    first_name: first_name,
    last_name: last_name,
    email: email,
    admin: true
  )
end

# -------------------------- Concierge Methods --------------------------------

# Method that creates a hotel instance
def create_hotel(name:, address:)
  Hotel.create(
    name: name,
    address: address
  )
end

# Method that creates a reservation
def create_reservation(user:, hotel:)
  reservation = Reservation.new(
    user: user,
    hotel: hotel,
    arrival_time: Time.new(2000, 1, 1, 15, 0, 0, "+00:00").utc,
    departure_time: Time.new(2000, 1, 1, 11, 0, 0, "+00:00").utc,
    check_in_date: Date.today + rand(0..10),
    reservation_number: rand(5555..9999),
    number_of_guests: rand(1..3),
    purpose: %w[travel work leisure].sample,
    channel: %w[website airbnb booking.com].sample,
    room_number: "#{rand(1..4)}0#{rand(1..3)}".to_i
  )
  reservation.check_out_date = reservation.check_in_date + rand(1..5)
  reservation.save
end

# Method that creates many amenities based on the names and categories provided.
def create_amenities
  amenities_hash = {
    'Essentials' => ["Wifi", "Heating", "A/C", "First Aid Kit"],
    'Bed & Bath' => ["Tooth Brush", "Comb", "Razor", "Washer", "Hairdryer", "Iron", "Towels & Linens", "Hangers", "Additional Towels","Additional Linens", "Extra Bed"],
    'Kitchen'    => ["Dishwasher", "Pots & Pans", "Plates & Glassware", "Cutlery", "Rice Cooker", "Salt & Pepper"],
    'Other'      => ["TV", "Desk & Chair", "Lobby Coffee Bar", "Slippers", "Vacuum Cleaner","Bluetooth Speaker", "Phone Charger",]
  }
  
  amenities_hash.each_pair do |category, amenities|
    amenities.each do |amenity|
      Amenity.create(
        name: amenity,
        category: category
      )
    end
  end
end

# Method that links an amenity with a hotel.
def create_hotel_amenity(amenity:, hotel:)
  requestables = ["Additional Towels","Additional Linens", "Extra Bed", "Vacuum Cleaner", "Rice Cooker", "Bluetooth Speaker", "Phone Charger", "Salt & Pepper"]
  
  HotelAmenity.create(
    amenity: amenity,
    hotel: hotel,
    requestable: requestables.include?(amenity.name)
  )
end

# Method that creates a time change request for a reservation.
def create_time_request
  TimeRequest.create(
    time: [ Time.new(2000, 1, 1, 15), Time.new(2000, 1, 1, 14), Time.new(2000, 1, 1, 13) ].sample,
    reservation: Reservation.all.sample,
    check_in: [true, false].sample,
    status: 'pending'
  )
end

# Method that creates an Article and HotelArticle for each of the articles in the array.
def create_articles(hotel:)
  titles = %w[house_manual neighborhood_guide recycling washer_&_dryer dishwasher heating wifi ]
  
  titles.each do |title|
    HotelArticle.create(article: Article.create(title: title), hotel: hotel)
  end
end

# ------------------------- Friends of L methods -----------------

# Method that creates an event.
def create_event(user)
  event = Event.new(
    title: "#{Faker::Food.dish} with friends",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    datetime: rand(Time.zone.now .. 4.days.from_now),
    venue: Faker::Restaurant.name,
    capacity: rand(2..8),
    category: Faker::Restaurant.type,
  )
  file = URI.open("https://source.unsplash.com/1600x900/?japanese/food&#{rand(10000)}")
  event.photo.attach(io: file, filename: "#{event.title}.png", content_type: 'image/png')
  event.end_time = event.datetime + rand(1..3).hours
  event.user = user
  event.save
end

# Method that creates between 4-6 tickets for an event.
def create_event_tickets(event)
  # Ensures that the event creator doesn't request to join his own event and no users request twice.
  unused_users = User.all.to_a.reject!{ |u| u == event.user}
  rand(4..6).times do
    ticket = Ticket.new(
      event: event,
      user: unused_users.sample
    )
    unused_users.delete(ticket.user)
    ticket.status = ['pending', 'accepted'].sample
    ticket.save
  end
end

# --------------------------------- Seed Creation --------------------------------



# Database Clearing
puts 'Clearing database'
destroy_everything
puts 'Database cleared successfully!'



# User creation
puts 'Creating 10 random users'
3.times { create_user }
puts '10 random users created successfully!.'

puts 'Creating 2 admin users'
create_admin(first_name: 'Zeke', last_name: 'Chanel', email: 'section@gmail.com')
create_admin(first_name: 'Khan', last_name: 'Surge', email: 'section2@gmail.com')
puts 'Admin users created successfully!'



# >>> Concierge L-related Seeds <<<
puts 'Creating Hotel instance'
ginza_east = create_hotel(name: 'Section L Ginza East', address: '1-14-5 Shintomi, Chuo-ku, Tokyo' )
puts 'Ginza East created!'

puts 'Creating one reservation per user'
User.all.each{ |user| create_reservation(user: user, hotel: ginza_east) }
puts 'Reservations created successfully!'

puts 'Creating amenities'
create_amenities
puts 'Amenities created successfully!'

puts 'Creating hotel_amenities (linking amenities with hotel)'
Amenity.all.each{ |amenity| create_hotel_amenity(amenity: amenity, hotel: ginza_east) }
puts 'Hotel amenities created successfully!'

puts 'Creating 10 time requests'
5.times{ create_time_request }
puts 'Time requests created successfully!'

puts 'Creating articles / Guides'
create_articles(hotel: ginza_east)
puts 'Articles / guides created successfully!!'



# Friends of L-related Seeds
puts 'Creating an event per user (~12)'
User.all.each{ |user| create_event(user) }
puts 'Events created successfully!'

puts 'Creating 4-6 tickets for each event'
Event.all.each{ |event| create_event_tickets(event) }
puts 'Tickets created successfully!'



# Completed message
puts 'Seeding completed. Have a nice day.'
