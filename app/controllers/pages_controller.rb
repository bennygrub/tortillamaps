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
    @location = request.location
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
