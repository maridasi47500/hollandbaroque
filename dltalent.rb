
require "nokogiri"
require "open-uri"
def dlthis(x,longurl)
@doc=Nokogiri::HTML(File.read("./#{x}.html"))
@doc1=@doc.css('.page-header')
@doc2=@doc.css('.pageet-content')
@concert=Pageet.new
@concert.url=longurl
@concert.title=@doc.css('h1').text.strip.squish
@concert.date=@doc1.css('.application-date').text.strip.squish
@concert.subtitle=@doc1.css('.subtitle p').text.strip.squish

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
end


urls=["https://www.hollandbaroque.com/educatie-talent/"]
urls=Nokogiri::HTML(URI.open(urls[0]))
urls=urls.css('a.more-link').map{|x|x.attributes['href'].value}
urls.each do |x|
`wget "#{x}" -O pagetalent.html` 
dlthis('pagetalent',x)
end

