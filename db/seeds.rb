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
    room_number: "#{rand(1..4)}#{rand(0..10)}".to_i
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
5.times do 
  amenity = Amenity.new(
    name: Faker::Appliance.equipment,
  )
  amenity.save
  HotelAmenity.create(amenity: amenity, hotel: hotel)
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
titles = %w[washer restaurants hairdryer kitchen bars]
titles.each do |title|
  article = Article.new(
    title: title,
  )
  article.save
  HotelArticle.create(article: article, hotel: hotel)
end

puts 'Seeding completed successfully. Have a nice day.'
