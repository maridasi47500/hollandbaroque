class Pagesite < Article
attr_accessor :my_url_en,:my_url_nl
before_validation do
self.url_en = self.my_url_en
self.url_nl = self.my_url_nl

end
def self.findbyurl(x)
y=Rails.application.routes.url_helpers.url_for(Rails.application.routes.recognize_path(x.split('?')[0]).merge(only_path: true))
p y
z=y+"/"
where("url_en = ? or url_nl = ? or url_en = ? or url_nl = ?",z,z,y, y)[0]
end
end