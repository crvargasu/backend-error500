# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
polygons = [
  '[{lat:-33.4163761 , lng: -70.5515917}, {lat: -33.4164545, lng: -70.5515112}, {lat: -33.4164186, lng: -70.5514469}, {lat: -33.4163358, lng: -70.5515220}, {lat: -33.4163761, lng: -70.5515917}]',
  '[{lng:-70.5515917 , lat-33.4163761}, {lng: -70.5515112 , lat:-33.4164545}, {lng: -70.5514469 , lat:-33.4164186}, {lng: -70.5515220 , lat:-33.4163358}, {lng:-70.5515917, lat: -33.4163761}]',
  '[{lng: -70.5490842, lat -33.4095826}, {lng:  -70.5490467, lat: -33.4095826}, {lng:  -70.5490547, lat: -33.4095289}, {lng:  -70.5490896, lat: -33.4095333,}, {lng: -70.5490896, lat:  -33.4095759} , {lng: -70.5490842, lat: -33.4095826}]',
  '[{lng: -70.5515521, lat -33.4045055}, {lng:  -70.5514851, lat: -33.4045301}, {lng:  -70.5514690, lat: -33.4045010}, {lng:  -70.5515307, lat: -33.4044831,}, {lng: -70.5515521, lat:  -33.4045010} , {lng: -70.5515521, lat: -33.4045055}]',
  '[{lng: -70.5983403, lat -33.4384428}, {lng:  -70.5983028, lat: -33.4384428}, {lng:  -70.5982894, lat: -33.4384921}, {lng:  -70.5983269, lat: -33.4385055,}, {lng: -70.5983457, lat:  -33.4384473} , {-70.5983403 -33.4384428}]',
  '[{lng: -70.6014302, lat -33.4405090}, {lng:  -70.6014383, lat: -33.4404754}, {lng:  -70.6013525, lat: -33.4404709}, {lng:  -70.6013471, lat: -33.4404955,}, {lng: -70.6014276, lat:  -33.4405090} , {-70.6014302 -33.4405090}]'
]

points = ['[{lat:-33.4163761 , lng: -70.5515917}]',
          '[{lng: -70.5515917 , lat: -33.4163761}',
          '[{lng: -70.5490842, lat: -33.4095826}]',
          '[{lng: -70.5515521, lat: -33.4045055}]',
          '[{lng: -70.5983403, lat: -33.4384428}]',
          '[{lng: -70.6014302, lat: -33.4405090}]']

(1..20).each do |number|
  User.create(
    email: "myemail#{number}@email.com",
    password: 'mypassword',
    name: 'name',
    picture: 'picture',
    street: 'street',
    city: 'city'
  )
end

(1..5).each do |number|
  Leaseholder.create(
    property_account: 'link',
    polygon: polygons[number - 1],
    center: points[number - 1],
    area: 4,
    mean_reviews: 0,
    description: 'mi estacionamiento',
    capacity: 2,
    highlimit: 10_000,
    credit: 0,
    status: true,
    id_picture_front: 'link',
    id_picture_back: 'link',
    user_id: number
  )
end

(5..20).each do |number|
  Lessor.create(
    credit: 0,
    mean_reviews: 0,
    user_id: number
  )
end

(1..5).each do |number|
  RentalAgreement.create(
    timestamp_start: '2021-01-01 00:00:00',
    timestamp_end: '2021-01-01 23:00:00',
    status: number % 3,
    lessor_id: number + 5,
    leaseholder_id: number,
    reasons: 'reasons for the rental agreement',
    offer_price: 1000,
    days_for_week: 3
  )
end
