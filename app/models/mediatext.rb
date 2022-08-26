class Mediatext < ApplicationRecord
belongs_to :article
translates :content, fallback: false
translates :title, fallback: false
translates :url, fallback: false
end
