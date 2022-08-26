require "nokogiri"
require "open-uri"
def concert_en(concert,doc)
longurl=doc.css('link[hreflang="en"]')[0].attributes['href'].value
raise "pb article en anglais" if !longurl

`wget "#{longurl}" -O mynews_en.html`

@doc_en=Nokogiri::HTML(File.read("./mynews_en.html"))
@doc1_en=@doc_en.css('.page-header')
@doc2_en=@doc_en.css('.news-content')
concert.url_en=longurl
concert.title_en=@doc.css('h1').text.strip.squish
concert.date_en=@doc1.css('.post-date').text.strip.squish
concert.subtitle_en=@doc1.css('.subtitle p').text.strip.squish
rescue => e
p e.message
p "pb article anglais"
end
def ticker_en(ticker,i)

t=@doc_en.css('.ticker-container')[i]

ticker.text_en=t.css('.js-marquee')[0].text.strip rescue nil
ticker.subscript_en=t.css('.ticker-subscript')[0].text.strip.squish rescue nil

end
def dl_content_en(content,i)

p=@doc2_en.css('.page-content p')[i]
 content.text_en= p.inner_html.strip.squish
rescue => e
p "pb article content"
p e.message
end
def media_en(med,i)
p=@doc2_en.css('.page-content .wp-block-media-text')[i]


med.content_en= p.css('.wp-block-media-text__content')[0].inner_html
med.url_en= p.css('img')[0].attributes['src'].value
rescue => e
p e.message

end
