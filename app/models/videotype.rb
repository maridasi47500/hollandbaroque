class Videotype < ApplicationRecord
translates :name, fallback: false
translates :url, fallback: false
has_and_belongs_to_many :postkls, :join_table => :videoshavetypes
def self.findbyname(x)
Videotype.where('name_en like ? or name_nl like ?',x,x)[0]
end
end