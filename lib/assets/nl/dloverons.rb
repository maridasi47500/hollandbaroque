
require "nokogiri"
require "open-uri"
require "./lib/assets/dloverons_en"
def dlthisfast(x,longurl,subtitle,subtitleen)
@doc=Nokogiri::HTML(File.read("./#{x}.html"))
@doc1=@doc.css('.page-header')
@doc2=@doc.css('.single-page-content')
@concert=Aboutus.new
@concert.url_nl=longurl
@concert.title_nl=@doc.css('h1').text.strip.squish
@concert.image=@doc.css('img')[2].attributes['src'].value rescue nil

@concert.subtitle_nl=subtitle
overons_en(@concert,@doc,subtitleen)


@concert.save
@ids.push(@concert.try(:id))
rescue => e
p e.inspect
@concert.save
@ids.push(@concert.try(:id))
end
def dlthis(x,longurl,subtitle,subtitleen)
@doc=Nokogiri::HTML(File.read("./#{x}.html"))
@doc1=@doc.css('.page-header')
@doc2=@doc.css('.single-page-content')
@concert=Aboutus.new
@concert.url_nl=longurl
@concert.title_nl=@doc.css('h1').text.strip.squish
@concert.image=@doc.css('img')[2].attributes['src'].value rescue nil

@concert.subtitle_nl=subtitle
overons_en(@concert,@doc,subtitleen)
@concert.save
@ids.push(@concert.try(:id))
@doc2.css('.page-content p').each_with_index do |p,i|

 @content=@concert.contents.new(text_nl: p.inner_html.strip.squish)
dl_content_en(@content,i)
@content.orderid=p.parent.children.select{|x|x.name != "text"}.index(p)

@content.save
end
@doc2.css('.page-content .wp-block-media-text').each_with_index do |p,i|

@mediatext=@concert.mediatexts.new(type:"Picture",content: p.css('.wp-block-media-text__content')[0].inner_html,url: p.css('img')[0].attributes['src'].value)
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
yt.css('img.attachment-medium').each_with_index do |img,i|
@image=@yt.images.new(name_nl: img.attributes['src'].value, title_nl: img.attributes['alt'].value)

swiper_en(@image,y,i)
@image.save
end

end
@doc.css('.wp-block-gallery').each do |t|
@yt=@concert.galleries.new
@yt.orderid=t.parent.children.select{|x|x.name != "text"}.index(t)

@yt.save
t.css('img').each do |img|
@img=@yt.images.new(name: img.attributes['src'].value)
@img.save
end
end
@doc.css('.ticker-container').each_with_index do |t,i|
@yt=@concert.tickers.new
@yt.orderid=t.parent.children.select{|x|x.name != "text"}.index(t)

@yt.text_nl=t.css('.js-marquee')[0].text.strip.squish rescue nil
@yt.subscript_nl=t.css('.ticker-subscript')[0].text.strip.squish rescue nil
ticker_en(@yt,i)
@yt.save
rescue => e
end
@doc.css('.musicus-card').each_with_index do |card,i|
p card.text
@musician=@concert.musicians.new
@musician.link=card.attributes['data-link'].value.split('/').without('').last
@musician.image=card.css('.musicus-card-image')[0].attributes['src'].value
@musician.title=card.css('h2')[0].text.strip.squish
@musician.subtitle_nl=card.css('.musicus-card-subtitle')[0].text.strip.squish
musi_en(@musician,i)
@musician.save
rescue => e
p e.inspect
end
end


url="https://www.hollandbaroque.com/over-ons/"
`wget "#{url}" -O pageoo1.html` 
@urls=Nokogiri::HTML(File.read("pageoo1.html"))
urls=@urls.css('.more-link').map{|x|x.attributes['href'].value}
subtitles=@urls.css('.more-link').map{|x|x.parent.css('p')[0].text}
enlongurl=@urls.css('link[hreflang="en"]')[0].attributes['href'].value rescue nil
if enlongurl
`wget "#{enlongurl}" -O thisnameen.html`
docen=Nokogiri::HTML(File.read("./thisnameen.html"))

###
 
###

descriptionsen=docen.css('.more-link').map{|x|[x.attributes['href'].value.split('/').without('').last,x.parent.css('p')[0].text]}.to_h
###
else
descriptionsen=[]
end
urls.each_with_index do |x,i|
lien='https://www.hollandbaroque.com'
if !(x[0] == "/") && !(x[0..3] == "http") 
x="/"+x
end

if !x.include?(lien)
x=lien+x
end
p x
`wget "#{x}" -O pageoo.html`
###




@ids||=[]
if x.include?('partners') || x.include?('perskit') || x.include?('concertarchief')
dlthisfast('pageoo',x,subtitles[i],descriptionsen) 
else
dlthis('pageoo',x,subtitles[i],descriptionsen)
end
end
p @ids

