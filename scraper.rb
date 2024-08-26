require 'nokogiri'
require 'open-uri'

url = 'https://www.bbc.com/news'

html = URI.open(url)

doc = Nokogiri::HTML(html)

headlines = doc.css('div')

headlines.each_with_index do |headline, index|
  puts "#{index + 1}. #{headline.text.strip}"
end
