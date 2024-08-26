require 'nokogiri'
require 'open-uri'

url = gets.chomp

html = URI.open(url)

doc = Nokogiri::HTML(html)

links = doc.css('a')

links.each_with_index do |link, index|
    puts "#{index + 1}. #{link['href']}"
end
