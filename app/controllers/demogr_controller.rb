require 'geokit'

class DemogrController < ApplicationController

  before_filter :authenticate_user!
  
=begin
GET  /api/v1/demographics?parameters
=end

=begin
Google Geocoding results:
results[0].formatted_address: "275-291 Bedford Ave, Brooklyn, NY 11211, USA",
results[1].formatted_address: "Williamsburg, NY, USA",
results[2].formatted_address: "New York 11211, USA",
results[3].formatted_address: "Kings, New York, USA",
results[4].formatted_address: "Brooklyn, New York, USA",
results[5].formatted_address: "New York, New York, USA",
results[6].formatted_address: "New York, USA",
results[7].formatted_address: "United States"
=end


  def show
    coords = Geokit::Geocoders::MultiGeocoder.geocode("45660")
    location = Geokit::Geocoders::GoogleGeocoder.reverse_geocode([coords.lat, coords.lng])
    render :json => location.full_address

    
  end

end
