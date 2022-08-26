class Content < ApplicationRecord
belongs_to :article
translates :text, fallback: false
end
