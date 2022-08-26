
require "nokogiri"
require "open-uri"
def overons_en(concert,doc)
longurl=doc.css('link[hreflang="en"]')[0].attributes['href'].value
`wget "#{longurl}" -O thisname_en.html`
@doc_en=Nokogiri::HTML(File.read("./thisname_en.html"))
@doc1_en=@doc_en.css('.page-header')
@doc2_en=@doc_en.css('.pageet-content')
concert.url_en=longurl
concert.title_en=@doc_en.css('h1').text.strip.squish

concert.subtitle_en=@doc1_en.css('.page-header-content p').text.strip.squish

@concert.date_en=@doc1_en.css('.application-date').text.strip.squish

rescue => e
p e.inspect
end



def dl_content_en(content,i)
p=@doc2_en.css('.page-content p, .page-content h3')[i]
 content.text_en= p.inner_html.strip.squish
rescue => e
p e.inspect
end
def media_en(med,i)
p=@doc2_en.css('.page-content .wp-block-media-text')[i]


med.content_en= p.css('.wp-block-media-text__content')[0].inner_html
med.url_en= p.css('img')[0].attributes['src'].value
rescue => e
p e.inspect
end

def swiper_en(x,y,i)
t=@doc_en.css('.swiper-container')[y].css('img.attachment-medium')[i]
x.title_en= t.attributes['alt'].value
rescue => e
p e.inspect
end
def ticker_en(ticker,i)

t=@doc_en.css('.ticker-container')[i]

ticker.text_en=t.css('.js-marquee')[0].text.strip.squish rescue nil
ticker.subscript_en=t.css('.ticker-subscript')[0].text.strip.squish rescue nil
rescue => e
p e.inspect
end
def musi_en(musician,i)
card=@doc_en.css('.musicus-card')[i]
musician.subtitle_en=card.css('.musicus-card-subtitle')[0].text.strip.squish
rescue => e
p e.inspect
end
