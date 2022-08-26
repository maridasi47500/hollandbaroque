require "nokogiri"
require "open-uri"
require "./lib/assets/nl/dlluister_then"

def dlthis(url,related,longurl,listtags)

@doc=Nokogiri::HTML(File.read(url))
@doc1=@doc.css('.page-header')
@doc2=@doc.css('.postkl-content')
concert=Postkl.find_or_initialize_by url_en: longurl
concert if concert.persisted?

concert.title_en=@doc.css('h1').text.strip.squish
concert.subtitle_en=@doc1.css('.subtitle p').text.strip.squish
concert.image=@doc.css('img')[2].attributes['src'].value rescue nil

concert.save
begin
dlthis_nl(concert,@doc)
concert.save
rescue => e
p e.message
p "pb article néerlandais" 
end
@listtags=listtags
concert.tags << listtags.select{|x|x}

@doc2.css('.page-content p').each_with_index do |p,i|

 @content=concert.contents.new(text_en: p.inner_html.strip.squish)
dl_content_nl(@content,i)
@content.save
end
@doc2.css('.page-content .wp-block-media-text').each_with_index do |p,i|

@mediatext=concert.mediatexts.new(type:"Picture",content_en: p.css('.wp-block-media-text__content')[0].inner_html,url_en: p.css('img')[0].attributes['src'].value)
media_nl(@mediatext,i)
@mediatext.save
end
@doc2.css('.playdate-row').each_with_index do |p,i|
#
#dates des concerts
@playdate=concert.playtimes.new
@playdate.link_en=p.css('a')[0].attributes['href'].value
@playdate.namelink_en=p.css('a')[0].text.strip.squish
@playdate.date=p.css('.date')[0].text.strip.squish
@playdate.time=p.css('.time')[0].text.strip.squish
@playdate.place=p.css('.locations')[0].text.strip.squish.split(', ')[0]
@playdate.city=p.css('.locations')[0].text.strip.squish.split(', ')[1]
date_nl(@playdate,i)
@playdate.save
end
@doc.css('.wp-block-embed-youtube').each_with_index do |yt,i|
@yt=concert.youtubes.new(url: yt.css('iframe')[0].attributes['src'].value)
youtube_nl(@yt,i)
@yt.save
end
if related
@doc.css('.postkl-cards-related').each do |yt|
thatlink= yt.css('a').map{|x|x.attributes['href'].value}
p thatlink
@thatlink=thatlink
mylisttags=yt.css('.postkl-card-type').map {|x|Videotype.findbyname(x.text.squish.strip)}
@mylisttags=mylisttags

`wget "#{thatlink}" -O luister1.html`
concert.otherarticles << dlthis("./luister1.html",false,thatlink,mylisttags)
end
end
concert
end
url="https://www.hollandbaroque.com/en/watchandlisten/"
`wget "#{url}" -O luister2.html`
@urls=Nokogiri::HTML(File.read("./luister2.html"))
urls=@urls.css('.postkl-card')

urls.each do |card|
@card=card
p @card
x=card.attributes ? (card.attributes['onclick'].value.split('=')[1] rescue card.attributes['href'].value).gsub("'",'').gsub(';','') : nil
listtags=card.css('.postkl-card-type').map {|x|Videotype.findbyname(x.text.squish.strip)}
lien='https://www.hollandbaroque.com'
if !x.include?(lien)
x=lien+x
end
p x
`wget "#{x}" -O luister.html`
dlthis("./luister.html",true,x,listtags)

end
