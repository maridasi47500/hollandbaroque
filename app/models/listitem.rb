class Listitem < ApplicationRecord
belongs_to :list
translates :text, fallback: false
end