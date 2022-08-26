class Playdateswrapper < ApplicationRecord
belongs_to :article
belongs_to :concert, foreign_key: "article_id" 
end