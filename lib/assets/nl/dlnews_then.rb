require "nokogiri"
require "open-uri"
def concert_nl(concert,doc)
longurl=doc.css('link[hreflang="nl"]')[0].attributes['href'].value
raise "pb article en neerlandais" if !longurl

`wget "#{longurl}" -O mynews_nl.html`

@doc_nl=Nokogiri::HTML(File.read("./mynews_nl.html"))
@doc1_nl=@doc_nl.css('.page-header')
@doc2_nl=@doc_nl.css('.news-content')
concert.url_nl=longurl
concert.title_nl=@doc_nl.css('h1').text.strip.squish
concert.date_nl=@doc1_nl.css('.post-date').text.strip.squish
concert.subtitle_nl=@doc1_nl.css('.subtitle p, .page-header-content p').text.strip.squish
rescue => e
p e.message
p "pb article neerlandais"
end
def ticker_nl(ticker,i)

t=@doc_nl.css('.ticker-container')[i]

ticker.text_nl=t.css('.js-marquee')[0].text.strip rescue nil
ticker.subscript_nl=t.css('.ticker-subscript')[0].text.strip.squish rescue nil

end
def dl_content_nl(content,i)

p=@doc2_nl.css('.page-content p')[i]
 content.text_nl= p.inner_html.strip.squish
rescue => e
p "pb article content"
p e.message
end
def media_nl(med,i)
p=@doc2_nl.css('.page-content .wp-block-media-text')[i]


med.content_nl= p.css('.wp-block-media-text__content')[0].inner_html
med.url_nl= p.css('img')[0].attributes['src'].value
rescue => e
p e.message

end
