
require "nokogiri"
require "open-uri"
def dlthis(x,longurl)
@doc=Nokogiri::HTML(File.read("./#{x}.html"))
@doc1=@doc.css('.page-header')
@doc2=@doc.css('.single-page-content')
@concert=Overons.new
@concert.url=longurl
@concert.title=@doc.css('h1').text.strip.squish

@concert.subtitle=@doc1.css('h3').text.strip.squish

@concert.save
@doc2.css('.page-content p').each do |p|

 @content=@concert.contents.new(text: p.inner_html.strip.squish)
@content.save
end
@doc2.css('.page-content .wp-block-media-text').each do |p|

@mediatext=@concert.mediatexts.new(type:"Picture",content: p.css('.wp-block-media-text__content')[0].inner_html,url: p.css('img')[0].attributes['src'].value)
@mediatext.save
end
@doc.css('.wp-block-embed-youtube').each do |yt|
@yt=@concert.youtubes.new(url: yt.css('iframe')[0].attributes['src'].value)
@yt.save

end
@doc.css('.swiper-container').each do |yt|
@yt=@concert.swipers.new
@yt.save
yt.css('img.attachment-medium').each do |img|
@image=@yt.images.new(name: img.attributes['src'].value, title: img.attributes['alt'].value)
@image.save
end

end
@doc.css('.wp-block-gallery').each do |t|
@yt=@concert.galleries.new
@yt.save
t.css('img').each do |img|
@img=@yt.images.new(name: img.attributes['src'].value)
@img.save
end
end
@doc.css('.ticker-container').each do |t|
@yt=@concert.tickers.new
@yt.text=t.css('.js-marquee')[0].text.strip.squish rescue nil
@yt.subscript=t.css('.ticker-subscript')[0].text.strip.squish rescue nil
@yt.save
rescue => e
end
@doc.css('.musicus-card').each do |card|
p card.text
@musician=@concert.musicians.new
@musician.link=card.attributes['data-link'].value
@musician.image=card.css('.musicus-card-image')[0].attributes['src'].value
@musician.title=card.css('h2')[0].text.strip.squish
@musician.subtitle=card.css('.musicus-card-subtitle')[0].text.strip.squish
@musician.save
rescue => e
p e.message
end
end


url="https://www.hollandbaroque.com/over-ons/"
`wget "#{url}" -O pageoo1.html` 
@urls=Nokogiri::HTML(File.read("pageoo1.html"))
urls=@urls.css('.more-link').map{|x|x.attributes['href'].value}
urls.each do |x|

lien='https://www.hollandbaroque.com'
if !x.include?(lien)
x=lien+x
end
p x
`wget "#{x}" -O pageoo.html` 
dlthis('pageoo',x)
end

