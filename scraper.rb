require 'nokogiri'
require 'open-uri'
require 'csv'
require 'uri'

url = ARGV[0] || gets.chomp
output_file = ARGV[1] || 'links.csv'

begin
  html = URI.open(url, "User-Agent" => "Mozilla/5.0")
  doc = Nokogiri::HTML(html)

  links = doc.css('a')
  filtered_links = links.select { |link| link['href'] =~ /^http/ }

  puts "Found #{filtered_links.size} links."

  CSV.open(output_file, 'wb') do |csv|
    csv << ['Index', 'Title', 'Link']
    filtered_links.each_with_index do |link, index|
      title = link.text.strip.empty? ? "No Title" : link.text.strip
      absolute_link = URI.join(url, link['href']).to_s
      csv << [index + 1, title, absolute_link]
    end
  end

  puts "Links saved to #{output_file}"

rescue OpenURI::HTTPError => e
  puts "HTTP Error: #{e.message}"
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
