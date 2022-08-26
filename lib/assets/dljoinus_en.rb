require "nokogiri"
require "open-uri"
def friend_en_1(friend,doc,i)
longurl=doc.css('link[hreflang="en"]')[0].attributes['href'].value

`wget "#{longurl}" -O joinus_en.html`
@doc_en=Nokogiri::HTML(File.open("./joinus_en.html"))
item=@doc.css('div.page-card')[i]
friend.title_en=item.css('.page-card-title')[0].text
friend.url_en=item.css('a')[0].attributes['href'].value
end
def content_en(content,i)
t=@doc_en.css('.page-content')[0].children[i]
content.text_en= t.to_html



end
def friend_en(friend,doc)
longurl=doc.css('link[hreflang="en"]')[0].attributes['href'].value

`wget "#{longurl}" -O joinus_en.html`
@doc_en=Nokogiri::HTML(File.open("./joinus_en.html"))

friend.title_en=@doc_en.css('.page-header-content h1').text.strip.squish
friend.subtitle_en=@doc_en.css('.page-header-content p').text.strip.squish
friend.url_en=longurl
rescue => e
p e.inspect
end
def list_en(item,doc,i,j)
item.text_en=@doc_en.css('article.page-content ul')[i].css('li')[j]
rescue => e
p e.inspect
end
def media_en(med,i)
p=@doc_en.css('article.page-content .wp-block-media-text')[i]


med.content_en= p.css('.wp-block-media-text__content')[0].inner_html
med.url_en= p.css('img')[0].attributes['src'].value
rescue => e
p e.inspect
end
def content_en(content,i)
t=@doc_en.css('.page-content')[0].children[i]
content.text_en= t.to_html
rescue => e
p e.inspect


end
