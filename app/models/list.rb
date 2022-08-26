class List < ApplicationRecord
belongs_to :article
has_many :listitems
end