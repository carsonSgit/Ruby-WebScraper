require 'nokogiri'
require 'open-uri'
require 'csv'

url = ARGV[0] || gets.chomp

html = URI.open(url)

doc = Nokogiri::HTML(html)

links = doc.css('a')

filtered_links = links.select { |link| link['href'] =~ /^http/ }

CSV.open('links.csv', 'wb') do |csv|
    csv << ['Index', 'Title', 'Link']
    filtered_links.each_with_index do |link, index|
      title = link.text.strip
      absolute_link = URI.join(url, link['href']).to_s
      csv << [index + 1, title, absolute_link]
    end
  end