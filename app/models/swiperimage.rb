class Swiperimage < ApplicationRecord
belongs_to :swiper
translates :title, fallback: false
end
