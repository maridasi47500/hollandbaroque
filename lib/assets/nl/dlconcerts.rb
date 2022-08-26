require "nokogiri"
require "open-uri"
require "./lib/assets/dlconcerts_en"
def dlthis(url,longurl)
@doc=Nokogiri::HTML(File.read(url))

@doc1=@doc.css('.page-header')
@doc2=@doc.css('.concert-content')

@concert=Concert.find_or_initialize_by url_nl: longurl
@concert if @concert.persisted?
@concert.title_nl=@doc.css('h1').text.strip.squish
@concert.date_nl=@doc1.css('.concert-date').text.strip.squish
@concert.subtitle_nl=@doc1.css('.subtitle p').text.strip.squish
@concert.image=@doc.css('img')[2].attributes['src'].value rescue nil
dlthis_en_1(@doc,@concert)
@concert.save
@doc2.css('[id*="product-component"]').each do |product|
myproduct=@concert.products.find_or_initialize_by orderid: product.parent.children.select{|x|x.name != "text"}.index(product)

myproduct.productid=product.attributes["id"].value.gsub("product-component-","")
myproduct.save
end
@doc2.css('.playdates-wrapper').each_with_index do |p,i|
l=@concert.playdateswrappers.find_or_initialize_by orderid: p.parent.children.select{|h|h.name != "text"}.index(p)
l.save

end
@doc2.css('#object_table_concert').each_with_index do |p,i|
l=@concert.object_table_concerts.find_or_initialize_by orderid: p.parent.children.select{|h|h.name != "text"}.index(p)
l.save

end
@doc.css('.wp-block-embed-youtube').each_with_index do |yt,i|
@yt=@concert.youtubes.new(url: yt.css('iframe')[0].attributes['src'].value)
@yt.title_nl=yt.css('iframe')[0].attributes['title'].value rescue nil
@yt.orderid=yt.parent.children.select{|x|x.name != "text"}.index(yt)

youtube_en(@yt,i)
@yt.save
end

@doc2.css('.page-content p').each_with_index do |p,i|

 @content=@concert.contents.new(text_nl: p.inner_html.strip.squish)
save_content_fr(@content,i)
@content.orderid=p.parent.children.select{|x|x.name != "text"}.index(p)

@content.save
end
@doc2.css('.page-content .wp-block-media-text').each_with_index do |p,i|
begin
@mediatext=@concert.mediatexts.new(type:"Picture",content_nl: p.css('.wp-block-media-text__content')[0].inner_html,url: p.css('img')[0].attributes['src'].value)
mediatext_en(@mediatext,i)
@mediatext.orderid=p.parent.children.select{|x|x.name != "text"}.index(p)

@mediatext.save
rescue => e
p "pb inner_html 001"
end
end
@doc2.css('.playdate-row').each_with_index do |p,i|
#
#dates des concerts
begin
@playdate=@concert.playtimes.new
begin
@playdate.link_nl=p.css('a')[0].attributes['href'].value
rescue => e
p "rescue attributes 000001"
end
@playdate.namelink_nl=p.css('a')[0].text.strip.squish
@playdate.date=p.css('.date')[0].text.strip.squish
@playdate.time=p.css('.time')[0].text.strip.squish
@playdate.place=p.css('.locations')[0].text.strip.squish.split(', ')[0]
@playdate.city=p.css('.locations')[0].text.strip.squish.split(', ')[1]

rescue => e
p "rescue 0001"
end
playdate_en(@playdate,i)
@playdate.save
end


@doc.css('#object_table_concert table tbody tr').to_a.each_with_index do |date,i|

@playdate=@concert.playtimes.new

@playdate.date=date.css('td')[1].text.strip.squish.split(' ')[0]
@playdate.time=date.css('td')[1].text.strip.squish.split(' ')[1]
@playdate.place=date.css('td')[2].text.strip.squish
@playdate.city=date.css('td')[3].text.strip.squish

@playdate.save

rescue => e

p "pb date old concert"
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
