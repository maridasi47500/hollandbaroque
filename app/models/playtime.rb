class Playtime < ApplicationRecord
belongs_to :concert
belongs_to :location

attr_accessor :city, :place
before_validation :set_my_location
def set_my_location
self.location = Location.find_or_initialize_by(city: self.city,place: self.place)
end

def date=(x)
p x
x=x.downcase
p x
I18n.t('date.day_names',locale: :nl).map(&:downcase).zip(I18n.t('date.day_names',locale: :en).map(&:downcase)).each {|a,b|x.gsub!(a,b)}
p x
I18n.t('date.abbr_month_names',locale: :nl).select{|x|x}.map(&:downcase).zip(I18n.t('date.abbr_month_names',locale: :en).select{|x|x}.map(&:downcase)).each {|a,b|x.gsub!(a,b)}
p x

self.write_attribute(:date, x.to_date)
rescue => e
p e.message
end
def date


self.read_attribute(:date)

end
end
