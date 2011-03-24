require 'geokit'
require 'rest-client'
require 'json'

class DemogrController < ApplicationController

  before_filter :authenticate_user!, :increment_api_count
  
=begin
GET  /api/v1/demographics?parameters
=end

  def show
    coords = Geokit::Geocoders::MultiGeocoder.geocode(params[:ip]) if !params[:id].nil?
    coords = Geokit::LatLng.normalize(params[:ll]) if !params[:ll].nil?
    response = RestClient.get "http://maps.googleapis.com/maps/api/geocode/json?latlng=#{coords.lat},#{coords.lng}&sensor=false"

    data = JSON.parse(response)

    township, county, state = ""

    data['results'][0]['address_components'].each { |type|
      if(type['types'][0] == "administrative_area_level_3")
        township = type['long_name']
      elsif(type['types'][0] == "administrative_area_level_2")
        county = type['long_name']
      elsif(type['types'][0] == "administrative_area_level_1")
        state = type['long_name']
      end
    }

    query = DemographicRegion.where(:Geography => /^#{township}.*#{county}.*#{state}/)

    result = query.execute.to_a

    render :json => result
  end

  protected

  def increment_api_count
    if(current_user.api_requests.nil?)
      current_user.api_requests = 0
    end
    current_user.api_requests += 1
    current_user.save!
  end

end
