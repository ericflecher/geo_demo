require 'net/http'

When /^I execute a request for geo\-demographic data based on IP '(\d+)'$/ do

  @response = Net::HTTP.get(URI.parse("http://localhost:3000/api/v1/demographics?ip=10.34.75.106"))
end

Then /^I should receive geo\-demographic data$/ do
end
