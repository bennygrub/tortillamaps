desc 'Send out emails to rootstrappers'
task mas_restaurants: :environment do
  require 'net/http'
  require 'json'
  
  if ENV['query']
    query = ENV['query'].gsub(" ","+")
    url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{query}&radius=20&key=AIzaSyDzYPWSWVUkOfCrwFy7CFov4rzEKa93mo0"
  else
    query = "nada"
    puts "you need to add a query like this query='blah'"
    exit
  end
  uri = URI(url)
  response = Net::HTTP.get(uri)
  a = JSON.parse(response)

  a["results"].each do |restaurant|

    rest = Restaurant.find_or_create_by(name:restaurant["name"]) do |r|
      r.name = restaurant["name"]
      r.address = restaurant["formatted_address"]
      r.latitude = restaurant["geometry"]["location"]["lat"].to_f
      r.longitude = restaurant["geometry"]["location"]["lng"].to_f
      r.place_id = restaurant["place_id"]
      r.rating = restaurant["rating"].to_f
      r.price = restaurant["price_level"].to_i
      #r.phone = details["international_phone_number"]
      #r.hours = details["opening_hours"]["weekday_text"].map{|a| "#{a} </br>"}.join
    end
    url = "https://maps.googleapis.com/maps/api/place/details/json?placeid=#{rest.place_id}&key=AIzaSyDzYPWSWVUkOfCrwFy7CFov4rzEKa93mo0"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    b = JSON.parse(response)
    details = b["result"]

    rest.phone = details["international_phone_number"]
    rest.hours = details["opening_hours"]["weekday_text"].map{|a| "#{a} </br>"}.join
    
    #binding.pry
    rest.save
    
  end
end
puts "Finished adding restaurants"