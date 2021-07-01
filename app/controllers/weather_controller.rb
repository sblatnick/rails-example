require 'json'
require 'typhoeus'

class WeatherController < ApplicationController
  def index
    locations = [
      2487610,
      2442047,
      2366355
    ]

    threads = Array.new
    locations.each do |location|
      threads.append(Thread.new{get_weather(location)})
    end

    places = Array.new
    threads.each do |thread|
      thread.join
      places.append(thread[:result])
    end
    @places = places
  end

  def get_weather(location)
    request = Typhoeus::Request.new("https://www.metaweather.com/api/location/" + location.to_s + "/", {method: 'get'})
    response = request.run
    results = JSON.parse(response.body)
    puts "Title: ", results['title']
    sum = 0
    cnt = 0
    results['consolidated_weather'].each do |result|
      puts "Max Temp: ", result['max_temp']
      sum += result['max_temp']
      cnt += 1
    end
    Thread.current[:result] = { 'name' => results['title'], 'max_temp' => "%.2f" % [sum / cnt] }
  end

end
