class Ticker < ApplicationRecord
belongs_to :article
translates :text, fallback: false
translates :subscript, fallback: false
end
