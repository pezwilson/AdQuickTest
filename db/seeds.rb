require 'net/http'
require 'uri'
require 'csv'

def open(url)
  Net::HTTP.get(URI.parse(url))
end

url = 'https://d26dzxoao6i3hh.cloudfront.net/items/3q0W442w1B1I1h1M142j/billboard%20voting%20seed.csv'
content = Net::HTTP.get(URI.parse(url))

csv = CSV.parse(content, :headers => true)
csv.each do |row|
  Billboard.create!(name: row[0], image: row[1])
end
