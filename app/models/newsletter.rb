class Newsletter < ApplicationRecord
validates_presence_of :firstname,:lastname,:email
before_validation :mycheck
def mycheck
if self.brochures == true
self.errors.add(:street,:blank) if self.street.blank?
self.errors.add(:housenumber,:blank) if self.housenumber.blank?
self.errors.add(:postcode,:blank) if self.postcode.blank?
self.errors.add(:city,:blank) if self.city.blank?
self.errors.add(:country,:blank) if self.country.blank?
end
end
end