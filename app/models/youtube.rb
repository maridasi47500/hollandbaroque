class Youtube < ApplicationRecord
belongs_to :article
translates :title, fallback: false
end
