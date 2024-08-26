<div>
 <img src="https://github.com/user-attachments/assets/34490945-20ba-4001-9a43-61bbd026f45f" width="500"/>
</div>

# Web Scraper 🤖
Learning Ruby one step at a time...

> [!IMPORTANT]
> This is my introduction to Ruby! I have experience with similar languages (i.e. `Python`, `Kotlin`, `JavaScript`, etc.) but have never even seen the syntax before making this, so it may not be my best work 😢.
>> A wise man once told me, "Learn Ruby, you'll like it."

## Overview 🌍

This simple web scraper takes any user-inputted `URL`, scrapes all **hyperlinks** from the given `URL`, and outputs them to a **CSV**. This can easily be integrated into a machine learning project to routinely update a **CSV**. All you need to do is update the content the `Nokogiri` object is looking for, just like any other scraper.

## How to Use 🔧

1. Install the necessary gems:
    > These are the pre-built packages/libraries that have functionalities leveraged in this web scraper
   ```bash
   gem install nokogiri
   gem install csv
   ```

2. Run the scraper script:
   ```ruby
    require 'nokogiri'
    require 'open-uri'
    require 'csv'
    require 'uri'

    puts "Please input the URL you want to scrape: "

    url = ARGV[0] || gets.chomp
    output_file = ARGV[1] || 'output.csv'

    begin
    html = URI.open(url, "User-Agent" => "Mozilla/5.0")
    doc = Nokogiri::HTML(html)

    links = doc.css('a')
    filtered_links = links.select { |link| link['href'] =~ /^http/ }

    CSV.open(output_file, 'wb') do |csv|
        csv << ['Index', 'Title', 'Link']
        filtered_links.each_with_index do |link, index|
        title = link.text.strip.empty? ? "No Title" : link.text.strip
        absolute_link = URI.join(url, link['href']).to_s
        csv << [index + 1, title, absolute_link]
        end
    end

    puts "Total links found: #{filtered_links.size}"
    puts "Links saved to #{output_file}"

    rescue OpenURI::HTTPError => e
        puts "HTTP Error: #{e.message}"
    rescue CSV::MalformedCSVError => e
        puts "CSV Error: #{e.message}"
    rescue StandardError => e
        puts "An error occurred: #{e.message}"
    end
   ```

   > Here are some sample URLs you could use:
   >> ```
   >> https://www.bbc.com/news
   >> https://www.theweathernetwork.com/en
   >> https://github.com/
   >> ```

3. Check the generated `output.csv` file for the scraped hyperlinks.

## Sample Outputs 📊

After running the scraper on a sample URL, your `output.csv` might look like this:

```
Index,Title,Link
1,Audio,https://www.bbc.co.uk/sounds
2,Weather,https://www.bbc.com/weather
3,Newsletters,https://www.bbc.com/newsletters
```

## Resources Used 📚 

- [Ruby Docs](https://www.ruby-lang.org/en/documentation/): General Ruby docs (install, syntax, etc.).
- [Nokogiri](https://nokogiri.org/index.html#parsing-and-querying): Web scraping parser.
- [Gets Method](https://www.codecademy.com/resources/docs/ruby/user-input): How Ruby gets user input.
- [Ruby CSV](https://ruby-doc.org/stdlib-2.6.1/libdoc/csv/rdoc/CSV.html): Ruby CSV documentation.

