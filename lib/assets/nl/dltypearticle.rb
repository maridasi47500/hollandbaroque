require "nokogiri"
require "open-uri"
`wget "https://www.hollandbaroque.com/kijkenluister/" -O musicvideonl.html`
@doc=Nokogiri::HTML(File.read("./musicvideonl.html"))

longurl=@doc.css('link[hreflang="en"]')[0].attributes['href'].value
`wget "#{longurl}" -O musicvideoen.html`


@doc_en=Nokogiri::HTML(File.read("./musicvideoen.html"))

button_nl=@doc.css('.filter-button-option')
button_en=@doc_en.css('.filter-button-option')
button_nl.zip(button_en).each do |nl,en|
url1en=en.attributes['data-link'].value.split('/').without('').last

url1nl=nl.attributes['data-link'].value.split('/').without('').last


Videotype.find_or_create_by({
"url_en" => url1en,
"url_nl" => url1nl,
"name_en" => en.text.strip.squish,
"name_nl" => nl.text.strip.squish

})
end
Videotype.find_or_create_by({
"url_en" => "featured",
"url_nl" => "uitgelicht",
"name_en" => "featured",
"name_nl" => "uitgelicht"

})