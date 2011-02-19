

Given /^'(\d+)'$/ do |arg1|
  puts arg1
  arg1
end

When /^I restfully request geo\-demographic data$/ do

end


Then /^I should receive geo\-demographic data$/ do
  response.status.should == 200
end
