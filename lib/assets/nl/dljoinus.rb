require "nokogiri"
require "open-uri"
require "./lib/assets/dljoinus_en"
Joinus.delete_all
Commercial.delete_all
Private.delete_all
urls=["https://www.hollandbaroque.com/doe-mee"]
urls2=["./doemee.html"]
`wget "#{urls[0]}" -O doemee1.html`
@doc=Nokogiri::HTML(File.read("./doemee1.html"))
@url=@doc.css('div.page-card')
@url.each_with_index do |url,i|
@friend=Joinus.new

@friend.image=url.css('img')[0].attributes['src'].value
@friend.title_nl=url.css('.page-card-title')[0].text
@friend.url_nl=url.css('a')[0].attributes['href'].value
friend_en_1(@friend,@doc,i)
@friend.save


end

urls=["https://www.hollandbaroque.com/doe-mee/particulier"]
urls2=["./doemee1.html","./doemee2.html"]
`wget "#{urls[0]}" -O doemee1.html`
@url=urls2.map{|x|Nokogiri::HTML(File.read(x)).css('.more-link')}.sum.map{|x|x.attributes['href'].value}
@url.each do |url|
`wget "#{url}" -O doemee2.html`
@doc=Nokogiri::HTML(File.open("./doemee2.html"))
@friend=Private.new
@friend.image=@doc.css('.concert-card-image')[0].attributes['src'].value

@friend.title_nl=@doc.css('.page-header-content h1').text.strip.squish
@friend.subtitle_nl=@doc.css('.page-header-content p').text.strip.squish
@friend.url_nl=url
friend_en(@friend,@doc)
@friend.save
@doc.css('.page-content .wp-block-media-text').each_with_index do |p,i|

@mediatext=@friend.mediatexts.new(type:"Picture",content_nl: p.css('.wp-block-media-text__content')[0].inner_html,url_nl: p.css('img')[0].attributes['src'].value)
@mediatext.orderid=p.parent.children.select{|x|x.name != "text"}.index(p)

media_en(@mediatext,i)
@mediatext.save
end
@doc.css('article.page-content ul').each_with_index do |content,i|
mylist=@friend.lists.new orderid: content.parent.children.select{|x|x.name != "text"}.index(content)
mylist.save
content.css('li').each_with_index do |item,itemid|

mylistitem=mylist.listitems.find_or_initialize_by text_nl: item.text.squish.strip
list_en(mylistitem,@doc,i,itemid)
mylistitem.save
end 


end
@doc.css('article.page-content')[0].css('p, h2, h3, h4').each_with_index do |content,i|
cont=@friend.contents.new(text_nl: content.to_html)
cont.type="Text" if content.name == "p"
cont.type="H2title" if content.name == "h2"
cont.type="H3title" if content.name == "h3"
cont.type="H4title" if content.name == "h4"
content_en(cont,i)
cont.orderid=content.parent.children.select{|x|x.name != "text"}.index(content)
cont.save
end

end

urls=["https://www.hollandbaroque.com/doe-mee/zakelijk"]
urls2=["./doemee1.html","./doemee3.html"]
`wget "#{urls[0]}" -O doemee3.html`
@url=urls2.map{|x|Nokogiri::HTML(File.read("doemee3.html")).css('.more-link')}.sum.map{|x|x.attributes['href'].value}
@url.each do |url|
`wget "#{url}" -O doemee.html`
@doc=Nokogiri::HTML(File.open("./doemee.html"))
@friend=Commercial.find_or_initialize_by title_nl: @doc.css('.page-header-content h1').text.strip.squish

@friend.image=@doc.css('.concert-card-image')[0].attributes['src'].value

@friend.subtitle_nl=@doc.css('.page-header-content p').text.strip.squish
@friend.url_nl=url
friend_en(@friend,@doc)
@friend.save
@doc.css('.page-content .wp-block-media-text').each_with_index do |p,i|

@mediatext=@friend.mediatexts.new(type:"Picture",content_nl: p.css('.wp-block-media-text__content')[0].inner_html,url_nl: p.css('img')[0].attributes['src'].value)
@mediatext.orderid=p.parent.children.select{|x|x.name != "text"}.index(p)

media_en(@mediatext,i)
@mediatext.save
end
@doc.css('article.page-content  ul').each_with_index do |content,i|
mylist=@friend.lists.new orderid: content.parent.children.select{|x|x.name != "text"}.index(content)
mylist.save
content.css('li').each do |item|

mylistitem=mylist.listitems.find_or_initialize_by text_nl: item.text.squish.strip
list_en(mylistitem,@doc,i,itemid)
mylistitem.save
end 


end
@doc.css('article.page-content')[0].css('p, h2, h3, h4').each_with_index do |content,i|
cont=@friend.contents.new(text_nl: content.to_html)
cont.type="Text" if content.name == "p"
cont.type="H2title" if content.name == "h2"
cont.type="H3title" if content.name == "h3"
cont.type="H4title" if content.name == "h4"
content_en(cont,i)
cont.orderid=content.parent.children.select{|x|x.name != "text"}.index(content)

cont.save
end

end

