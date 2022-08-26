class Musician < ApplicationRecord
belongs_to :article
translates :subtitle, fallback: false
end
