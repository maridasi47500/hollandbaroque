
require "nokogiri"
require "open-uri"
require "./lib/assets/dlapply_en"
def dlthis(x,longurl)
@doc=Nokogiri::HTML(File.read("./#{x}.html"))
@doc1=@doc.css('.page-header.split-header.childpage-header')
@doc2=@doc.css('.pageet-content.childpage-content')
@concert=Apply.new
@concert.url_nl=longurl.gsub('https://www.hollandbaroque.com/educatie-talent/','').split('/').without('')[0]
@concert.title_nl=@doc.css('h1').text.strip.squish
@concert.date_nl=@doc1.css('.application-date').text.strip.squish
@concert.subtitle_nl=@doc1.css('.page-header-content p').text.strip.squish
@concert.image=@doc.css('img')[2].attributes['src'].value rescue nil

overons_en(@concert,@doc)
@concert.save
@doc2.css('.wp-block-file').each do |file|
@y=@concert.files.find_or_initialize_by filename: file.css('a')[0].text

@y.orderid=file.parent.children.select{|x|x.name != "text"}.index(file)
@y.mytype=file.css('object')[0].attributes['type'].value
@y.url=file.css('object')[0].attributes['data'].value
@y.label=file.css('object')[0].attributes['aria-label'].value
@y.save
rescue => e
p e.inspect
end
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
str="page_apply_nl"
str2="etpage_nl1"
urls.each do |x|
`wget "#{x}" -O #{str2}.html` 
@docno1nl=Nokogiri::HTML(File.read("./#{str2}.html"))
@docno1nl.css('a[href*="apply-for"]').map{|x|x.attributes['href'].value}.each do |myurl|
`wget "#{myurl}" -O #{str}.html`
dlthis(str,x)
end

end