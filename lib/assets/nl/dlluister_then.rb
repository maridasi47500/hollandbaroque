require "nokogiri"
require "open-uri"
def dlthis_nl(concert,doc)
longurl=doc.css('link[hreflang="nl"]')[0].attributes['href'].value

@doc_nl=Nokogiri::HTML(File.read(longurl))
@doc1_nl=@doc_nl.css('.page-header')
@doc2_nl=@doc_nl.css('.postkl-content')
concert.url_nl=longurl
concert.title_nl=@doc_nl.css('h1').text.strip.squish
concert.subtitle_nl=@doc1_nl.css('.subtitle p').text.strip.squish

end

def dl_content_nl(content,i)
p=@doc2_nl.css('.page-content p')[i]
 content.text_nl= p.inner_html.strip.squish
rescue => e
p e.message
end
def media_nl(med,i)
p=@doc2_nl.css('.page-content .wp-block-media-text')[i]


med.content_nl= p.css('.wp-block-media-text__content')[0].inner_html
med.url_nl= p.css('img')[0].attributes['src'].value
rescue => e
p e.message
end
def date_nl(date,i)
p=@doc2.css('.playdate-row')[i]
#
#dates des concerts
date=@concert.playtimes.new
date.link_nl=p.css('a')[0].attributes['href'].value
date.namelink_nl=p.css('a')[0].text.strip.squish
date.date=p.css('.date')[0].text.strip.squish
date.time=p.css('.time')[0].text.strip.squish
date.place=p.css('.locations')[0].text.strip.squish.split(', ')[0]
date.city=p.css('.locations')[0].text.strip.squish.split(', ')[1]
rescue => e
p e.message
end

def youtube_nl(y,i)
yt=@doc_nl.css('.wp-block-embed-youtube')[i]
y.title_nl=yt.css('iframe')[0].attributes['title'].value rescue nil

rescue => e
p e.message

end