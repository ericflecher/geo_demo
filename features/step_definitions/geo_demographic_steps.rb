

Given /^a zip_code$/ do
  44017
end

When /^I restfully request geo\-demographic data$/ do
  get '/geo_demo'
end


Then /^I should receive geo\-demographic data$/ do
  response.status.should == 200
end
