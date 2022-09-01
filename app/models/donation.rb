class Donation < ApplicationRecord
before_validation :validamount
def validamount
if amount == "0" && (self.namely.empty? || self.namely.blank? || self.namely.nil?)
self.errors.add(:namely)
end
end
end