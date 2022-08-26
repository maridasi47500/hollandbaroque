require "nokogiri"
require "open-uri"
def dlthis_en_1(doc,concert)
longurl=doc.css('link[hreflang="en"]')[0].attributes['href'].value
raise "pb article en anglais" if !longurl

@doc_en=Nokogiri::HTML(URI.open(longurl))

@doc1_en=@doc_en.css('.page-header')
@doc2_en=@doc_en.css('.concert-content')

concert.url_en=longurl
concert.title_en=@doc_en.css('h1').text.strip.squish
concert.date_en=@doc1_en.css('.concert-date').text.strip.squish
concert.subtitle_en=@doc1_en.css('.subtitle p').text.strip.squish

end
def youtube_en(y,i)
yt=@doc_en.css('.wp-block-embed-youtube')[i]
y.title_en=yt.css('iframe')[0].attributes['title'].value rescue nil


rescue => e
p e.message
end

def save_content_fr(content,i)

 begin
content.text_en= @doc2_en.css('.page-content p')[i].inner_html.strip.squish 
rescue => e
p "pb inner_html"
end
content.save
end
def mediatext_en(mediatext,i)
begin
mediatext.content_en=@doc2_en.css('.page-content p')[i].css('.wp-block-media-text__content')[0].inner_html
rescue => e
p "pb inner_html"
end
begin
mediatext.url_en= @doc2_en.css('.page-content p')[i].css('img')[0].attributes['src'].value
rescue => e
p "rescue attributes 0002"
end
end
def playdate_en(playdate,i)
p=@doc2_en.css('.playdate-row')[i]
playdate.link_en=p.css('a')[0].attributes['href'].value rescue nil
playdate.namelink_en=p.css('a')[0].text.strip.squish rescue nil

rescue => e
p "rescue PLAY date"
end
