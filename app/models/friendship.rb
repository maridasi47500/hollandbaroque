class Friendship < ApplicationRecord
validates_presence_of :typefriendship, :amount
validates_presence_of :iban, :authorize, :firstname
validates_presence_of :lastname, :street
  validates_presence_of :housenumber, :postcode
validates_presence_of :place, :land
validates_presence_of :email
end