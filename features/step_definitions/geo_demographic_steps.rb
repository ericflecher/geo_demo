require 'net/http'
require 'deomographic_importer'
include DeomographicImporter

Given /^I have specified specific demographic variables I am interested in$/ do
  post "/api/v1/demographics.json?", { :query => 'Universe.TOTAL POPULATION.Median age.Total (Estimate)', :ip => '76.190.225.221', :api_key => "#{@user.authentication_token}" }
end

And /^geodemographic data in the database$/ do
  importDemographicFile("all_Ohio/dc_acs_2009_5yr_g00__data1_lite.txt")
end

And /^I should only receive the demographic variables I requested$/ do
  puts last_response.body
end

When /^I execute a request for geo\-demographic data based on "([^"]*)" "([^"]*)"$/ do |format, location|
  clean_location = CGI::escape(location)
  get("/api/v1/demographics.json?#{format}=#{clean_location}&api_key=#{@user.authentication_token}" )
end

When /^I execute a request for geo\-demographic data based on "([^"]*)" "([^"]*)" with a filter$/ do |format, location|
  clean_location = CGI::escape(location)
  post "/api/v1/demographics.json?", { :query => 'Universe.TOTAL POPULATION.Median age.Total (Estimate)', format.to_sym => "#{clean_location}", :api_key => "#{@user.authentication_token}" }
end

Then /^I should receive geo\-demographic data$/ do
  last_response.status.should == 200
end

Then /^the user should have their api_request incremented by one$/ do
  User.first(:conditions => {:id => @user.id}).requests.count.should == (@api_requests + 1)
end

When /^I execute a bad request for geo\-demographic data$/ do
  get("/api/v1/demographics.json?api_key=#{@user.authentication_token}" )
end

Then /^I should receive a status (\d+) message$/ do |arg1|
  pending #last_response.status.should == 400
end

