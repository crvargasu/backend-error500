# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
polygons = [
    "POLYGON((-70.5515917 -33.4163761, -70.5515112 -33.4164545, -70.5514469 -33.4164186, -70.5515220 -33.4163358, -70.5515917 -33.4163761))",
    "POLYGON(( -70.5490842 -33.4095826, -70.5490467 -33.4095826, -70.5490547 -33.4095289, -70.5490896 -33.4095333, -70.5490896 -33.4095759, -70.5490842 -33.4095826))",
    "POLYGON(( -70.5515521 -33.4045055, -70.5514851 -33.4045301, -70.5514690 -33.4045010, -70.5515307 -33.4044831, -70.5515521 -33.4045010, -70.5515521 -33.4045055))",
    "POLYGON(( -70.5983403 -33.4384428, -70.5983028 -33.4384428, -70.5982894 -33.4384921, -70.5983269 -33.4385055, -70.5983457 -33.4384473, -70.5983403 -33.4384428))",
    "POLYGON(( -70.6014302 -33.4405090, -70.6014383 -33.4404754, -70.6013525 -33.4404709, -70.6013471 -33.4404955, -70.6014276 -33.4405090, -70.6014302 -33.4405090))"]

(1..20).each do |number|

    User.create(
        "email": "myemail#{number}@email.com",
        "password": "mypassword",
        "name": "name",
        "picture": "picture",
        "street": "street",
        "city": "city"
    )
end

(1..5).each do |number|

    Leaseholder.create(
        "property_account": "link",
        "polygon": polygons[number - 1],
        "mean_reviews": 0,
        "credit": 0,
        "status": true,
        "id_picture_front": "link",
        "id_picture_back": "link",
        "user_id": number
    )
end

(5..20).each do |number|

    Lessor.create(
        "credit": 0,
        "mean_reviews": 0,
        "user_id": number
        )
end

(1..5).each do |number|

    RentalAgreement.create(
        "timestamp_start": "2021-01-01 00:00:00",
        "timestamp_end": "2021-01-01 23:00:00",
        "status": number%3,
        "lessor_id": number+5,
        "leaseholder_id": number,
        "reasons": "reasons for the rental agreement",
        "offer_price": 1000,
        )
end
