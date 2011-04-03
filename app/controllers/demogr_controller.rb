require 'geokit'
require 'rest-client'
require 'json'

class DemogrController < ApplicationController

  before_filter :authenticate_user!
  
=begin
GET  /api/v1/demographics?parameters
=end

  def show
  
    case true
        when !params[:ll].nil?
            coords = Geokit::LatLng.normalize(params[:ll])
            response = RestClient.get "http://maps.googleapis.com/maps/api/geocode/json?latlng=#{coords.lat},#{coords.lng}&sensor=false"
        when !params[:address].nil?
            clean_location = CGI::escape(params[:address])
            response = RestClient.get "http://maps.googleapis.com/maps/api/geocode/json?address=#{clean_location}&sensor=false"
        when !params[:ip].nil?
            coords = Geokit::Geocoders::MultiGeocoder.geocode(params[:ip])
            response = RestClient.get "http://maps.googleapis.com/maps/api/geocode/json?latlng=#{coords.lat},#{coords.lng}&sensor=false"
        else
            render :json => "Missing criteria", :status => :bad_request
            return
    end
        
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
    increment_api_count params.to_s, "#{township}, #{county}, #{state}", result
    render :json => result
  end

  protected

  def increment_api_count(query, location, response)
    request = Request.new(
        :query => query,
        :location => location,
        :response => response,
        :date => Time.now.utc)
    current_user.requests << request
    current_user.save!
  end

end
