require "nokogiri"
require "open-uri"
#routes=["doe-mee/zakelijk","doe-mee/particulier","educatie-talent","doe-mee","contact","winkel","concerten","kijkenluister","over-ons","nieuws"]
routes=["doe-mee/zakelijk","doe-mee/particulier"]
routes.each do |route|
url_nl="https://www.hollandbaroque.com/"
url_nl << route
`wget "#{url_nl}" -O url1_nl.html`
doc=Nokogiri::HTML(File.read("url1_nl.html"))
url_en=doc.css('link[hreflang="en"]')[0].attributes['href'].value
`wget "#{url_en}" -O url1_en.html`

doc_en=Nokogiri::HTML(File.read("./url1_en.html"))
page=Pagesite.new
page.my_url_en=url_en.gsub("https://www.hollandbaroque.com",'')
page.my_url_nl=url_nl.gsub("https://www.hollandbaroque.com","")
page.title_en=doc_en.css('h1')[0].text.squish.strip
page.title_nl=doc.css('h1')[0].text.squish.strip
page.intro_en=doc_en.css('.page-content p').map(&:text).join('').squish.strip
page.intro_nl=doc.css('.page-content p').map(&:text).join('').squish.strip
page.save
end