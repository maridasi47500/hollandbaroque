class Swiper < ApplicationRecord
belongs_to :article
has_many :images, class_name: "Swiperimage"
end
