class PagesController < ApplicationController
  def home
    @users = Restaurant.all
    @hash = Gmaps4rails.build_markers(@users) do |restaurant, marker|
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.picture({
        :url => "/chili.png",
        :width   => 32,
        :height  => 32
      })
      marker.infowindow render_to_string(:partial => "/restaurants/infobox", :locals => { :restaurant => restaurant})
      marker.title restaurant.name
      marker.json({ :id => restaurant.id, :name => restaurant.name })
    end
  end

  def about
  end

  def contact
  end
end
