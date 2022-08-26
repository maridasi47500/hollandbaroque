require "nokogiri"
require "open-uri"
require "./lib/assets/dltalent_en"
def dlthis(x,longurl)
@doc=Nokogiri::HTML(File.read("./#{x}.html"))
@doc1=@doc.css('.page-header')
@doc2=@doc.css('.pageet-content')
@concert=Pageet.new
@concert.url_nl=longurl
@concert.title_nl=@doc.css('h1').text.strip.squish
@concert.date_nl=@doc1.css('.application-date').text.strip.squish
@concert.subtitle_nl=@doc1.css('.page-header-content p').text.strip.squish
@concert.image=@doc.css('img')[2].attributes['src'].value rescue nil

overons_en(@concert,@doc)
@concert.save
@doc2.css('.page-content p, .page-content h3, .page-content h2').each_with_index do |p,i|

 @content=@concert.contents.new(text: p.inner_html.strip.squish)
@content.type="H2title" if p.name == "h2"
@content.type="H3title" if p.name == "h3"
dl_content_en(@content,i)
@content.orderid=p.parent.children.select{|x|x.name != "text"}.index(p)

@content.save
end
@doc2.css('.page-content .wp-block-media-text').each_with_index do |p,i|

@mediatext=@concert.mediatexts.new(type:"Picture",content_nl: p.css('.wp-block-media-text__content')[0].inner_html,url_nl: p.css('img')[0].attributes['src'].value)
@mediatext.orderid=p.parent.children.select{|x|x.name != "text"}.index(p)

media_en(@mediatext,i)
@mediatext.save
end
@doc.css('.wp-block-embed-youtube').each do |yt|
@yt=@concert.youtubes.new(url: yt.css('iframe')[0].attributes['src'].value)
@yt.orderid=yt.parent.children.select{|x|x.name != "text"}.index(yt)

@yt.save

end
@doc.css('.swiper-container').each_with_index do |yt,y|
@yt=@concert.swipers.new
@yt.orderid=yt.parent.children.select{|x|x.name != "text"}.index(yt)

@yt.save
yt.css('img.attachment-medium').each do |img,i|
@image=@yt.images.new(height: img.attributes['height'].value,width: img.attributes['width'].value,name: img.attributes['src'].value, title_nl: img.attributes['alt'].value)
swiper_en(@image,y,i)
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

