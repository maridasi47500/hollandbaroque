class Article < ApplicationRecord
translates :url, fallback: false
translates :title, fallback: false
translates :subtitle, fallback: false
translates :date, fallback: false
translates :intro, fallback: false
has_many :lists
validates :title_nl, :presence => true
has_many :contents
has_many :mediatexts
has_many :playdateswrappers
has_many :products
has_many :quotes
has_many :youtubes
has_many :texts
has_many :relatedposts
has_many :otherarticles, through: :relatedposts, source: :otherarticle
has_many :files, class_name: "Myfile"
def self.summaryres(s)
t="%#{s.downcase.gsub(' ','%')}%"
joins(:contents).group("articles.type").having("lower(articles.title_en) like ? or lower(articles.title_nl) like ? or lower(articles.subtitle_en) like ? or lower(articles.subtitle_nl) like ? or lower(contents.text_en) like ? or lower(contents.text_nl) like ? and articles.type is not null and articles.type != ''",t,t,t,t,t,t).count("distinct(articles.id)")

end
def self.search(s,page)
o=page.to_i == 0 ? 0 : (page.to_i - 1)
xx=o*50
limit(50).offset(o)
end
def self.search1(s)
t="%#{s.downcase.gsub(' ','%')}%"
joins(:contents).group("articles.id").having("lower(articles.title_en) like ? or lower(articles.title_nl) like ? or lower(articles.subtitle_en) like ? or lower(articles.subtitle_nl) like ? or lower(contents.text_en) like ? or lower(contents.text_nl) like ? and articles.type is not null and articles.type != ''",t,t,t,t,t,t)
end
def mycontrollername
model_name.singular.gsub("pageet","etpage").gsub('concert',"concerts").gsub('private',"/joinus/private")
end
def self.findbyurl(x)
case I18n.locale.to_s
when "en"
find_by_url_en(x)
when 'nl'
find_by_url_nl(x)
end
end

has_many :swipers
has_many :galleries
has_many :tickers
has_many :musicians
has_many :wpcolumns
has_many :images

def mycontents
[lists, contents,mediatexts,youtubes,swipers,galleries,tickers,musicians,wpcolumns,images,files,products].sum.sort_by{|x|x.orderid}
end
before_validation :myarticle
def myarticle


myurl_en=self.url_en.to_s.gsub('https://www.hollandbaroque.com','')
myurl_en=myurl_en.split('/')
myurl_en.delete('')
self.url_en=myurl_en.last

myurl_nl=self.url_nl.to_s.gsub('https://www.hollandbaroque.com','')
myurl_nl=myurl_nl.split('/')
myurl_nl.delete('')
self.url_nl=myurl_nl.last
end
end
