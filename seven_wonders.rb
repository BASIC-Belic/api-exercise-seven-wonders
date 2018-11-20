require 'httparty'
require 'pry'



#Instuctor Google Maps API key: `AIzaSyBP30mYnbwKpZ0lCHtp6FuvcNSjNG0GsGM`

# url = "https://maps.googleapis.com/maps/api/geocode/json?&address=Great+Pyramid+of+Giza&key=AIzaSyBP30mYnbwKpZ0lCHtp6FuvcNSjNG0GsGM"
# response = HTTParty.get(url)
#
# puts "Latitude: #{response["results"][0]["geometry"]["location"]["lat"]}, Longitude: #{response["results"][0]["geometry"]["location"]["lng"]}"

class SevenWonders

  SEVEN_WONDERS = ["Great Pyramid of Giza", "Hanging Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]

  def initialize
    @urls = build_urls
    @wonder_hash = {}
  end

  def get_hash_stucture

    @urls.each do |url|
      response = HTTParty.get(url)
      get_wonder_hash(response)
      handle_response(response)
    end

  end

  private

  def build_urls

    @urls = SEVEN_WONDERS.map do|name|
      name = name.split.reverse.join('+')
      name_url = URI.encode("https://maps.googleapis.com/maps/api/geocode/json?&address=#{name}&key=AIzaSyBP30mYnbwKpZ0lCHtp6FuvcNSjNG0GsGM")
    end
    return @urls

  end

  def get_wonder_hash(response)
    if response["results"][0]
      location = response["results"][0]["geometry"]["location"]

      @wonder_hash < { response =>  location}
      return @wonder_hash
    end
  end

  def handle_response(response)
    #check the response code - did it work?
    #different for every API
    if response.code == 200 && response["status"] == "success"
      puts "Successfully got coordinates for location"
    else
      puts "Something went wrong"
      puts "Status #{response['status']}, code #{response['code']}"
      puts response
    end
  end
end

structure = SevenWonders.new
structure.get_hash_stucture


#
# wonder_hash = {}
#
# SEVEN_WONDERS.each do |wonder|
#   url = URI.encode("https://maps.googleapis.com/maps/api/geocode/json?&address=#{wonder}&key=AIzaSyBP30mYnbwKpZ0lCHtp6FuvcNSjNG0GsGM")
#
#   response = HTTParty.get(url)
#
#   location = response["results"][0]["geometry"]["location"]
#
#   wonder_hash[wonder] = location
# end
#
# puts "Final hash: #{wonder_hash}"
#
#
#
#
#
#
# #Example Output:
# #{"Great Pyramind of Giza"=>{"lat"=>29.9792345, "lng"=>31.1342019}, "Hanging Gardens of Babylon"=>{"lat"=>32.5422374, "lng"=>44.42103609999999}, "Colossus of Rhodes"=>{"lat"=>36.45106560000001, "lng"=>28.2258333}, "Pharos of Alexandria"=>{"lat"=>38.7904054, "lng"=>-77.040581}, "Statue of Zeus at Olympia"=>{"lat"=>37.6379375, "lng"=>21.6302601}, "Temple of Artemis"=>{"lat"=>37.9498715, "lng"=>27.3633807}, "Mausoleum at Halicarnassus"=>{"lat"=>37.038132, "lng"=>27.4243849}}
