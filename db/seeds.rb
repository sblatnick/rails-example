# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'typhoeus'

bearer_token = ENV["BEARER_TOKEN"]

request = Typhoeus::Request.new("https://api.twitter.com/1.1/search/tweets.json", {
  method: 'get',
  headers: {
    "User-Agent": "v2FullArchiveSearchRuby",
    "Authorization": "Bearer #{bearer_token}"
  },
  params: {
    "q": "Virgin Galactic",
    "count": 120
  }
})
response = request.run
results = JSON.parse(response.body)['statuses']

results.each do |result|
  puts result['id']
  Tweet.create(
    name: result['user']['name'],
    text: result['text']
  )
end
