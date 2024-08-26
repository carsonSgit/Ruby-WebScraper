require 'nokogiri'
require 'open-uri'
require 'csv'

url = ARGV[0] || gets.chomp

html = URI.open(url)

doc = Nokogiri::HTML(html)

links = doc.css('a')

filtered_links = links.select { |link| link['href'] =~ /^http/ }

CSV.open('links.csv', 'wb') do |csv|
    filtered_links.each_with_index do |link, index|
        csv << [index + 1, link['href']]
    end
end
