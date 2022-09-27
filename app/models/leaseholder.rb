class Leaseholder < User
    has_many :reviews
    has_many :rental_agreements
end
