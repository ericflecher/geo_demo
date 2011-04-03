require 'net/http'
require 'deomographic_importer'
include DeomographicImporter

And /^geodemographic data in the database$/ do
  importDemographicFile("all_Ohio/dc_acs_2009_5yr_g00__data1_lite.txt")
end

When /^I execute a request for geo\-demographic data based on "([^"]*)" "([^"]*)"$/ do |format, location|
  clean_location = CGI::escape(location)
  get("/api/v1/demographics.json?#{format}=#{clean_location}&api_key=#{@user.authentication_token}" )
end

Then /^I should receive geo\-demographic data$/ do
  last_response.status.should == 200
end

Then /^the user should have their api_request incremented by one$/ do
  User.first(:conditions => {:id => @user.id}).requests.count.should == (@api_requests + 1)
end
