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
  file = URI.open("https://source.unsplash.com/featured/?portrait")
  user.photo.attach(io: file, filename: "#{user.first_name}_#{user.last_name}.png", content_type: 'image/png')
  user.save
  return user
end

# ===================================    DEMO DAY -=======================================


# ============================================================================================



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
    'Additional Items' => ["Additional Towels", "Additional Linens", "Extra Bed", "Vacuum Cleaner", "Rice Cooker", "Bluetooth Speaker", "Phone Charger", "Salt & Pepper"],
    'Essentials'   => ["Wifi", "Heating", "A/C", "First Aid Kit"],
    'Bed & Bath'   => ["Tooth Brush", "Comb", "Razor", "Washer", "Hairdryer", "Iron", "Towels & Linens", "Hangers"],
    'Kitchen'      => ["Dishwasher", "Pots & Pans", "Plates & Glassware", "Cutlery"],
    'Other'        => ["TV", "Desk & Chair", "Lobby Coffee Bar", "Slippers"]
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
  HotelAmenity.create(
    amenity: amenity,
    hotel: hotel,
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
  titles = %w[house_manual recycling washer_&_dryer dishwasher heating wifi ]
  
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



# creating a specific user.
# Is PNG okay here?
# How do we attach images?
def create_specific_user(first_name:, last_name:, number:, age: )
  user = User.new(
    first_name: first_name,
    last_name: last_name,
    password: 'secret',
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    birthday: age.years.ago
  )
  user.email = "#{user.first_name}@gmail.com"

  url = "app/assets/images/user_#{number}.jpg"

  file = File.open(url)
  user.photo.attach(io: file, filename: "#{user.first_name}_#{user.last_name}.jpg", content_type: 'image/jpg')
  user.save!
end

# User creation
puts 'Creating 7 specific  users'

create_specific_user(first_name: 'Emily', last_name: 'Watson', number: 1, age: 27)
create_specific_user(first_name: 'Zeke', last_name: 'Chanel', number: 2, age: 29)
create_specific_user(first_name: 'Julian', last_name: 'Roberts', number: 3, age: 28)
create_specific_user(first_name: 'Evelyn', last_name: 'Jenner', number: 4, age: 29)
create_specific_user(first_name: 'Jenny', last_name: 'Henderson', number: 5, age: 31)
create_specific_user(first_name: 'Mike', last_name: 'Duville', number: 6, age: 39)
create_specific_user(first_name: 'Toshiaki', last_name: 'Yamada', number: 7, age: 34)


puts '7 specific users created successfully!.'


# >>> Concierge L-related Seeds <<<
puts 'Creating Hotel instance'
ginza_east = create_hotel(name: 'Section L Ginza East', address: '1-14-5 Shintomi, Chuo-ku, Tokyo' )
puts 'Ginza East created!'

puts 'Creating one reservation per user'
User.all.each{ |user| create_reservation(user: user, hotel: ginza_east) }
puts 'Reservations created successfully!'

# >>>>>>>>>>> ADMIN CREATION  <<<<<<<<<<<<<<<<<<<<<
puts 'Creating 2 admin users'
create_admin(first_name: 'Shinya', last_name: 'Tawata', email: 'section@gmail.com')
create_admin(first_name: 'Aki', last_name: 'Kitagawa', email: 'section2@gmail.com')
puts 'Admin users created successfully!'

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

# Method that creates an event.
def create_specific_event(user:, title:, venue:, category:, number:, datetime:)
  event = Event.new(
    title: title,
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    datetime: datetime,
    venue: venue,
    capacity: 5,
    category: category,
  )
  url = "app/assets/images/dine_#{number}.jpg"
  file = File.open(url)
  event.photo.attach(io: file, filename: "#{event.title}.png", content_type: 'image/png')
  event.end_time = event.datetime + rand(1..3).hours
  event.user = user
  event.save
end

# Friends of L-related Seeds
puts 'Creating 7 specific events'
create_specific_event(user: User.where(first_name: 'Emily').first, datetime: Time.new(2020, 8, 28, 20, 0, 0, "+00:00").utc, title: 'Sushi night with Emily!', venue: 'Section L Ginza', category: 'Cooking', number: 1)
create_specific_event(user: User.where(first_name: 'Zeke').first, datetime: Time.new(2020, 8, 29, 20, 0, 0, "+00:00").utc, title: 'Ramen Night at Takahashi Ginza', venue: 'Takahashi Ginza', category: 'Japanese', number: 2)
create_specific_event(user: User.where(first_name: 'Julian').first, datetime: Time.new(2020, 8, 30, 12, 0, 0, "+00:00").utc, title: 'Tonkatsu Lunch', venue: 'Miyagi', category: 'Japanese', number: 3)
create_specific_event(user: User.where(first_name: 'Evelyn').first, datetime: Time.new(2020, 8, 30, 17, 30, 0, "+00:00").utc, title: 'Seafood Hopping', venue: 'Tsukiji Market', category: 'Seafood', number: 4)
create_specific_event(user: User.where(first_name: 'Jenny').first, datetime: Time.new(2020, 8, 29, 18, 0, 0, "+00:00").utc, title: 'Craft Beer Pub Crawl', venue: 'iBrew Ginza', category: 'Drinking', number: 5)
create_specific_event(user: User.where(first_name: 'Mike').first, datetime: Time.new(2020, 9, 03, 19, 30, 0, "+00:00").utc, title: 'Let’s Cook Japanese Curry!', venue: 'Section L Ginza', category: 'Cooking', number: 6)
create_specific_event(user: User.where(first_name: 'Toshiaki').first, datetime: Time.new(2020, 9, 01, 14, 0, 0, "+00:00").utc, title: 'Coffee Hunt in Yanaka', venue: 'Yanaka & Sendagi', category: 'Coffee', number: 7)
puts 'Events created successfully!'

emily = User.where(first_name: 'Emily').first
emily.update(description: "Hi, I am a web designer from Australia.
  I came to Tokyo for a business trip and extending my trip for 2 weeks to explore. It is my 1st time in Japan and I love seafood!
  My favorite movies are Die Hard 1, Rambo: First Blood, and Predator; as you can see, I’m a big 80's action movie buff!
  I have a dog, whose name is Hafu, and he’s the love of my life!
  If you’re interested in getting to know me, let’s go out for a drink!")

event = Event.where(user: User.where(first_name: 'Emily').first).first
event.update(description: 'Hi, I\'m hosting a sushi making event in my room! We\'ll be making both vegetarian and some more adventurous rolls, to accommodate for everyone, so please request if you\'re interested in joining!')

puts 'Creating 4-6 tickets for each event'
Event.all.each{ |event| create_event_tickets(event) }
puts 'Tickets created successfully!'



create_specific_user(first_name: 'Saara', last_name: 'Makinen', number: 8, age: 32)

# Completed message
puts 'Seeding completed. Have a nice day.'
