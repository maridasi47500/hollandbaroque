class Relatedpost < ApplicationRecord
belongs_to :article
belongs_to :otherarticle, class_name:"Article"
validates_uniqueness_of :article_id, scope: :otherarticle_id
end
