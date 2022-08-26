require "nokogiri"
require "open-uri"
def dlthis(url,longurl)
@doc=Nokogiri::HTML(File.read(url))
@doc1=@doc.css('.page-header')
@doc2=@doc.css('.news-content')
@concert=News.new
@concert.url=longurl
@concert.title=@doc.css('h1').text.strip.squish
@concert.date=@doc1.css('.post-date').text.strip.squish
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

