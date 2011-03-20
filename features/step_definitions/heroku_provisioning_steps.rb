require "heroku/kensa"
require "heroku/kensa/check"
require "heroku/kensa/client"
require "heroku/kensa/manifest"
require "heroku/kensa/sso"

# Provisioning

When /^running the kensa provision "([^"]*)" test$/ do |test_name|
  @client = get_client([test_name])
end

Then /^the test should run with no fails$/ do
  result = @client.test
  result.should == true
end

# Deprovisioning

Given /^an account$/ do
  password = ActiveSupport::SecureRandom.base64(10)
  @user = User.create!(:name => "blah",
                      :email  => "blah@blah.com",
                      :password => password,
                      :password_confirmation => password)
end

And /^a "([^"]*)" plan$/ do |plan_type|
  @user.plan = Plan.new(:type => plan_type)
  @user.save!
end

When /^running the kensa deprovision "([^"]*)" test$/ do |test_name|
  @client = get_client([test_name, @user.id])
end

Then /^the test should run with no fails when deprovisioning$/ do
  result = @client.test
  result.should == true
end

And /^the user should not have a plan associated to them$/ do
  User.first.plan.should == nil
end


def get_client(test_args)
  Heroku::Kensa::Client.new(test_args, {:filename => "addon-manifest.json", :session => self})
end

# Plan Change

When /^running the kensa plan change "([^"]*)" with plan "([^"]*)"$/ do |test_name, plan_type|
  @client = get_client([test_name, @user.id, plan_type])
end

And /^the user should have only a "([^"]*)" plan associated$/ do |plan_type|
  User.first.plan.type.should == "premium"
end