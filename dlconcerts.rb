require "nokogiri"
require "open-uri"
def dlthis(url,longurl)
@doc=Nokogiri::HTML(File.read(url))
@doc1=@doc.css('.page-header')
@doc2=@doc.css('.concert-content')
@concert=Concert.new
@concert.url=longurl
@concert.title=@doc.css('h1').text.strip.squish
@concert.date=@doc1.css('.concert-date').text.strip.squish
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
rescue => e
p longurl
p e.message
end

url="https://www.hollandbaroque.com/concerten/"
`wget "#{url}" -O concerten2.html`
@urls=Nokogiri::HTML(File.read("./concerten2.html"))
url="https://www.hollandbaroque.com/over-ons/concertarchief/"
`wget "#{url}" -O concerten3.html`
@urls2=Nokogiri::HTML(File.read("./concerten3.html"))
urls=@urls.css('.concert-card').map{|x|(x.attributes['href'].value)}+@urls2.css('.archive-card').map{|x|(x.attributes['href'].value)}
urls.each do |x|

lien='https://www.hollandbaroque.com'
if !x.include?(lien)
x=lien+x
end
p x
`wget "#{x}" -O concerten.html`
dlthis("./concerten.html",x)

end
