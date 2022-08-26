require "nokogiri"
require "open-uri"
def dlthis(url,related,longurl)

@doc=Nokogiri::HTML(File.read(url))
@doc1=@doc.css('.page-header')
@doc2=@doc.css('.postkl-content')
@concert=Postkl.new
@concert.url=longurl
@concert.title=@doc.css('h1').text.strip.squish
@concert.subtitle=@doc1.css('.subtitle p').text.strip.squish
@concert.image=@doc.css('img')[2].attributes['src'].value rescue nil

@concert.save
@doc2.css('.page-content p').each do |p|

 @content=@concert.contents.new(text: p.inner_html.strip.squish)
@content.save
end
@doc2.css('.page-content .wp-block-media-text').each do |p|

@mediatext=@concert.mediatexts.new(type:"Picture",content: p.css('.wp-block-media-text__content')[0].inner_html,url: p.css('img')[0].attributes['src'].value)
@mediatext.save
end
@doc2.css('.playdate-row').each do |p|
#
#dates des concerts
@playdate=@concert.playtimes.new
@playdate.link=p.css('a')[0].attributes['href'].value
@playdate.namelink=p.css('a')[0].text.strip.squish
@playdate.date=p.css('.date')[0].text.strip.squish
@playdate.time=p.css('.time')[0].text.strip.squish
@playdate.place=p.css('.locations')[0].text.strip.squish.split(', ')[0]
@playdate.city=p.css('.locations')[0].text.strip.squish.split(', ')[1]
@playdate.save
end
@doc.css('.wp-block-embed-youtube').each do |yt|
@yt=@concert.youtubes.new(url: yt.css('iframe')[0].attributes['src'].value)
@yt.save
end
if related
@doc.css('.postkl-cards-related').each do |yt|
thatlink= yt.css('a').map{|x|x.attributes['href'].value}
p thatlink
@concert.otherarticles.new
`wget "#{thatlink} -O luister1.html"`
dlthis("./luister1.html",false,thatlink)
end
end
end
url="https://www.hollandbaroque.com/kijkenluister/"
`wget "#{url}" -O luister2.html`
@urls=Nokogiri::HTML(File.read("./luister2.html"))
urls=@urls.css('.postkl-card').map{|x|x.attributes ? (x.attributes['onclick'].value.split('=')[1] rescue x.attributes['href'].value).gsub("'",'').gsub(';','') : nil}.select{|x|x}

urls.each do |x|

lien='https://www.hollandbaroque.com'
if !x.include?(lien)
x=lien+x
end
p x
`wget "#{x}" -O luister.html`
dlthis("./luister.html",true,x)

end
