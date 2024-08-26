require 'nokogiri'
require 'open-uri'
require 'csv'

url = gets.chomp

html = URI.open(url)

doc = Nokogiri::HTML(html)

links = doc.css('a')

CSV.open('links.csv', 'wb') do |csv|
    links.each_with_index do |link, index|
        csv << [index + 1, link['href']]
    end
end
