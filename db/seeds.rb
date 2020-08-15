# Method that clears Database
def destroy_everything
  Hotel.destroy_all
  Amenity.destroy_all
  Article.destroy_all
  User.destroy_all
end

# Method that creates a reservation
def create_reservation(user, hotel)
  reservation = Reservation.new(
    user: user,
    hotel: hotel,
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

puts 'Clearing database...'
  destroy_everything
puts 'Database cleared.'

puts 'Creating 1 hotel...'
hotel = Hotel.new(
  address: '1-14-5 Shintomi, Chuo-ku, Tokyo',
  name: 'Section L Ginza East'
)
hotel.save

puts 'Creating 10 users with reservations...'
10.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password
  )
  user.save

  create_reservation(user, hotel)
end

# Create a user for admins to use.
puts 'Creating one user for the admin to use...'
admin = User.create(
  first_name: 'Zeke',
  last_name: 'Chanel',
  email: 'section@gmail.com',
  password: 'secret'
)
create_reservation(admin, hotel)
create_reservation(admin, hotel)


puts 'Creating Amenities...'
amenities_hash = {
  'Essentials' => ["Wifi", "Heating", "A/C", "First Aid Kit"],
  'Bed & Bath' => ["Tooth Brush", "Comb", "Razor", "Washer", "Hairdryer", "Iron", "Towels & Linens", "Hangers", "Additional Towels","Additional Linens", "Extra Bed"],
  'Kitchen'    => ["Dishwasher", "Pots & Pans", "Plates & Glassware", "Cutlery", "Rice Cooker", "Salt & Pepper"],
  'Other'      => ["TV", "Desk & Chair", "Lobby Coffee Bar", "Slippers", "Vacuum Cleaner","Bluetooth Speaker", "Phone Charger",]
}

requestables = ["Additional Towels","Additional Linens", "Extra Bed", "Vacuum Cleaner", "Rice Cooker", "Bluetooth Speaker", "Phone Charger", "Salt & Pepper"]


amenities_hash.each_pair do |category, amenities|
  amenities.each do |amenity|
    new_amenity = Amenity.new(
      name: amenity,
      category: category
    )
    new_amenity.save

    hotel_amenity = HotelAmenity.new(
      amenity: new_amenity,
      hotel: hotel
    )
    if requestables.include?(new_amenity.name)
      hotel_amenity.requestable = true
    else
      hotel_amenity.requestable = false
    end
    hotel_amenity.save

  end
end

puts 'Creating several time requests..'
3.times do
  time_request = TimeRequest.new(
    time: Time.now,
    reservation: Reservation.all.sample,
    check_in: true,
    status: 'pending'
  )
  time_request.save
end

puts 'Creating 5 articles...'
titles = %w[washer_&_dryer recycling elevator house_manual]
titles.each do |title|
  article = Article.new(
    title: title,
  )
  article.save
  HotelArticle.create(article: article, hotel: hotel)
end

puts 'Seeding completed successfully. Have a nice day.'
