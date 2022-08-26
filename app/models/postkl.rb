class Postkl < Article
has_and_belongs_to_many :tags, class_name: "Videotype", :join_table => :videoshavetypes
def self.featured

Videotype.find_or_create_by({
"url_en" => "featured",
"url_nl" => "uitgelicht",
"name_en" => "featured",
"name_nl" => "uitgelicht"

}).postkls.group("articles.id").having("title_#{I18n.locale.to_s} is not null and title_#{I18n.locale.to_s} != ''").order(:created_at =>:desc).limit(2)
end
def self.allposts
joins(:tags).group('articles.id')
end
def self.postspage(page)

end
def self.posts(page)
p=page.to_i == 0 ? 0 : ((page.to_i - 1) * 10)
limit(10).offset(p)
end
def self.firsthalf(page)
p=page.to_i == 0 ? 0 : ((page.to_i - 1) * 10)
limit(5).offset(p)
end
def self.secondhalf(page)
p=page.to_i == 0 ? 0 : ((page.to_i - 1) * 10 ) 
p+=5
limit(5).offset(p)
end

def self.moreposts(page)
p=page.to_i == 0 ? 0 : ((page.to_i - 1) * 10 )
p+=10 
limit(5).offset(p)
end
end
