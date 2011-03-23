require 'net/http'
require 'deomographic_importer'
include DeomographicImporter

Given /^an authenticatable user with a "([^"]*)" plan$/ do |plan_type|
  password = ActiveSupport::SecureRandom.base64(10)
  @user = User.create!(:name => "blah",
                       :email => "blah@blah.com",
                       :password => password,
                       :password_confirmation => password,
                       :api_requests => 3)
  @api_requests = 3
  @user.authentication_token = ActiveSupport::SecureRandom.base64(20)
  @user.plan = Plan.new(:type => plan_type)
  @user.save!
end

And /^geodemographic data in the database$/ do
  importDemographicFile("all_Ohio/dc_acs_2009_5yr_g00__data1_lite.txt")
end

When /^I execute a request for geo\-demographic data based on IP "([^"]*)"$/ do |ip_address|
  get("/api/v1/demographics.json?ip=" + ip_address + "&api_key=" + @user.authentication_token )
end

Then /^I should receive geo\-demographic data$/ do
  # right now this is returning a 302 to redirect the user to sign in... this is not the way this should work.
  # it is happening because of devise and I haven't figured out how to change it yet.
  # TODO: make this work properly
  last_response.status.should == 200
end

Then /^the user should have their api_request incremented by one$/ do
  User.first(:conditions => {:id => @user.id}).api_requests.should == (@api_requests + 1)
end
