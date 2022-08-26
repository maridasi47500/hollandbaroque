require "nokogiri"
require "open-uri"
def dlthis_en(concert,doc)
longurl=doc.css('link[hreflang="en"]')[0].attributes['href'].value
raise "pb article en anglais" if !longurl 
`wget "#{longurl}" -O myarticle_en.html`
@doc_en=Nokogiri::HTML(File.read("./myarticle_en.html"))
@doc1_en=@doc_en.css('.page-header')
@doc2_en=@doc_en.css('.postkl-content')
concert.url_en=longurl
concert.title_en=@doc_en.css('h1').text.strip.squish
concert.subtitle_en=@doc1_en.css('.subtitle p').text.strip.squish

end
def columns_en(a,i)

t=@doc_en.css(".wp-block-columns").select {|x|x.css('.wp-block-columns').length > 0}[i]
a.text_en=t.inner_html
end
def dl_content_en(content,i)
p=@doc2_en.css('.page-content p')[i]
 content.text_en= p.inner_html.strip.squish
rescue => e
p e.message
end
def media_en(med,i)
p=@doc2_en.css('.page-content .wp-block-media-text')[i]


med.content_en= p.css('.wp-block-media-text__content')[0].inner_html
med.url_en= p.css('img')[0].attributes['src'].value
rescue => e
p e.message
end
def date_en(date,i)
p=@doc2.css('.playdate-row')[i]
#
#dates des concerts
date=@concert.playtimes.new
date.link_en=p.css('a')[0].attributes['href'].value
date.namelink_en=p.css('a')[0].text.strip.squish
date.date=p.css('.date')[0].text.strip.squish
date.time=p.css('.time')[0].text.strip.squish
date.place=p.css('.locations')[0].text.strip.squish.split(', ')[0]
date.city=p.css('.locations')[0].text.strip.squish.split(', ')[1]
rescue => e
p e.message
end

def youtube_en(y,i)
yt=@doc_en.css('.wp-block-embed-youtube')[i]
y.title_en=yt.css('iframe')[0].attributes['title'].value rescue nil

rescue => e
p e.message

end