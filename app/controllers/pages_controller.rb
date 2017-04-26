class PagesController < ApplicationController
  def home
    @restaurants = Restaurant.where(published: true)
    @hash = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.picture({
        :url => "/chili-drop.png",
        :width   => 65,
        :height  => 65
      })
      marker.infowindow render_to_string(:partial => "/restaurants/infobox", :locals => { :restaurant => restaurant})
      marker.title restaurant.name
      marker.json({ :id => restaurant.id, :name => restaurant.name})
    end
    if request.location.ip == '::1'
      @location = request.safe_location
      rest_count = Restaurant.near([34.0900310, -118.3688430], 0.5, :units => :km).map{|a| a}.count
    else
      @location = request.safe_location
      rest_count = Restaurant.near([@location.latitude, @location.longitude], 1, :units => :km).map{|a| a}.count
    end
    if rest_count > 0
      @near_me = "yes"
    else
      @near_me = ""
    end
  end

  def about
  end

  def contact
  end

  def data
    restaurant = Restaurant.find(params[:restaurant][:id])
    respond_to do |format|
      format.json { render json: restaurant}# respond with the created JSON object
    end
  end
end
