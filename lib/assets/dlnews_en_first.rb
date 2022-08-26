require "nokogiri"
require "open-uri"
require "./lib/assets/nl/dlnews_then"

def dlthis(url,longurl)
@doc=Nokogiri::HTML(File.read(url))
@doc1=@doc.css('.page-header')
@doc2=@doc.css('.news-content')
@concert=News.find_or_initialize_by url_en: longurl
@concert if @concert.persisted?
@concert.image=@doc.css('img')[2].attributes['src'].value rescue nil

@concert.title_en=@doc.css('h1').text.strip.squish
@concert.date_en=@doc1.css('.post-date').text.strip.squish
@concert.subtitle_en=@doc1.css('.subtitle p, .page-header-content p').text.strip.squish
concert_nl(@concert,@doc)
@concert.save
@doc.css('.ticker-container').each_with_index do |t,i|
@yt=@concert.tickers.new
p t.css('.js-marquee')[0]
@yt.text_en=t.css('.js-marquee')[0].text.strip rescue nil
@yt.subscript_en=t.css('.ticker-subscript')[0].text.strip.squish rescue nil
@yt.orderid=t.parent.children.select{|x|x.name != "text"}.index(t)
ticker_nl(@yt,i)
@yt.save
rescue => e
end
@doc2.css('.wp-block-image').each_with_index do |p,i|

 @content=@concert.images.find_or_initialize_by source: p.css('img')[0].attributes['src'].value
@content.width=p.css('img')[0].attributes['width'].value
@content.height=p.css('img')[0].attributes['height'].value
@content.orderid=p.parent.children.select{|x|x.name != "text"}.index(p)

dl_content_nl(@content,i)
@content.save
end
@doc2.css('.page-content p').each_with_index do |p,i|

 @content=@concert.contents.new(text_en: p.inner_html.strip.squish)
@content.orderid=p.parent.children.select{|x|x.name != "text"}.index(p)

dl_content_nl(@content,i)
@content.save
end
@doc2.css('.page-content .wp-block-media-text').each_with_index do |p,i|

@mediatext=@concert.mediatexts.new(type:"Picture",content_en: p.css('.wp-block-media-text__content')[0].inner_html,url_en: p.css('img')[0].attributes['src'].value)
@mediatext.orderid=p.parent.children.select{|x|x.name != "text"}.index(p)

media_nl(@mediatext,i)
@mediatext.save
end
@doc.css('.wp-block-embed-youtube').each do |yt|
@yt=@concert.youtubes.new(url: yt.css('iframe')[0].attributes['src'].value)
@yt.orderid=yt.parent.children.select{|x|x.name != "text"}.index(yt)

@yt.save
end
end
typeart="news"
url="https://www.hollandbaroque.com/en/#{typeart}/"

`wget "#{url}" -O #{typeart}2.html`
@urls=Nokogiri::HTML(File.read("./#{typeart}2.html"))
urls=@urls.css('.news-card-imageblock').map{|x|(x.attributes['href'].value)}
urls.each do |x|

lien='https://www.hollandbaroque.com'
if !x.include?(lien)
x=lien+x
end
p x
`wget "#{x}" -O #{typeart}.html`
dlthis("./#{typeart}.html",x)

end

