# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts 'Creating 1 hotel...'
hotel = Hotel.new(
  address: 'Chuo-ku Shintomi 1-14-5',
  name: 'Section-L Ginza'
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

  reservation = Reservation.new(
    user: user,
    hotel: hotel,
    check_in_date: Date.new,
    check_out_date: Date.new,
    arrival_time: Time.now,
    departure_time: Time.now,
    reservation_number: rand(5555..9999),
    number_of_guests: rand(1..3),
    purpose: %w[travel work leisure].sample,
    channel: %w[website airbnb booking.com].sample,
    room_number: "#{rand(1..4)}#{rand(0..10)}".to_i
  )
  reservation.save
end

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