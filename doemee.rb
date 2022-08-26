require "nokogiri"
require "open-uri"
urls=["https://www.hollandbaroque.com/doe-mee/particulier","https://www.hollandbaroque.com/doe-mee/zakelijk"]
urls2=["./doemee1.html","./doemee2.html"]
`wget "#{urls[0]}" -O doemee1.html`
`wget "#{urls[1]}" -O doemee2.html`
@url=urls2.map{|x|Nokogiri::HTML(File.read(x)).css('.more-link')}.sum.map{|x|x.attributes['href'].value}
@url.each do |url|
`wget "#{url}" -O doemee.html`
@doc=Nokogiri::HTML(File.open("./doemee.html"))
@friend=Friendarticle.new
@friend.title=@doc.css('.page-header-content h1').text.strip.squish
@friend.subtitle=@doc.css('.page-header-content p').text.strip.squish
@friend.url=url
@friend.save
@doc.css('.page-content')[0].children.each do |content|
content=@friend.contents.new(text: content.to_html)
content.save
end

end
