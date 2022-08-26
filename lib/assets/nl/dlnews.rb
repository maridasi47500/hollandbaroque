require "nokogiri"
require "open-uri"
require "./lib/assets/dlnews_en"

def dlthis(url,longurl)
@doc=Nokogiri::HTML(File.read(url))
@doc1=@doc.css('.page-header')
@doc2=@doc.css('.news-content')
@concert=News.find_or_initialize_by url_nl: longurl
@concert if @concert.persisted?

@concert.title_nl=@doc.css('h1').text.strip.squish
@concert.date_nl=@doc1.css('.post-date').text.strip.squish
@concert.subtitle_nl=@doc1.css('.subtitle p').text.strip.squish
@concert.image=@doc.css('img')[2].attributes['src'].value rescue nil

concert_en(@concert,@doc)
@concert.save
@doc.css('.ticker-container').each_with_index do |t,i|
@yt=@concert.tickers.new
@yt.orderid=t.parent.children.select{|x|x.name != "text"}.index(t)

@yt.text_nl=t.css('.js-marquee')[0].text.strip rescue nil
@yt.subscript_nl=t.css('.ticker-subscript')[0].text.strip.squish rescue nil
ticker_en(@yt,i)
@yt.save
rescue => e
end
@doc2.css('.page-content p').each_with_index do |p,i|

 @content=@concert.contents.new(text_nl: p.inner_html.strip.squish)
@content.orderid=p.parent.children.select{|x|x.name != "text"}.index(p)

dl_content_en(@content,i)
@content.save
end
@doc2.css('.page-content .wp-block-media-text').each do |p|

@mediatext=@concert.mediatexts.new(type:"Picture",content_nl: p.css('.wp-block-media-text__content')[0].inner_html,url: p.css('img')[0].attributes['src'].value)
@mediatext.orderid=p.parent.children.select{|x|x.name != "text"}.index(p)

media_en(@mediatext,i)
@mediatext.save
end
@doc.css('.wp-block-embed-youtube').each do |yt|
@yt=@concert.youtubes.new(url: yt.css('iframe')[0].attributes['src'].value)
@yt.orderid=yt.parent.children.select{|x|x.name != "text"}.index(yt)

@yt.save
end
end
typeart="nieuws"
url="https://www.hollandbaroque.com/#{typeart}/"

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

