When /^a user creates a new account$/ do
  @user = User.create! :name => 'Test User', :email => 'test@email.com', :password => 'abc123', :password_confirmation => 'abc123'
  @user.plan = Plan.new
end

Then /^a new plan should be created for them$/ do
  plan_id = @user.plan
  plan_id.should_not =~ nil
end

Given /^a valid user account$/ do
  @user = User.create! :name => 'Test User', :email => 'test@email.com', :password => 'abc123', :password_confirmation => 'abc123'
  @user.plan = Plan.new :type => :basic, :limit => 1000
end

Then /^at the end of the month the user should receive a summary of their account$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^a user has a basic account$/ do
  @user = User.create! :name => 'Test User', :email => 'test@email.com', :password => 'abc123', :password_confirmation => 'abc123'
  @user.plan = Plan.new :type => :basic, :limit => 1000
end

When /^the user issues an upgrade request$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the user's plan should be a premium account$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the user's monthly plan summary should reflect those changes$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I am a logged in user with a basic account$/ do
  @user = User.create! :name => 'Test User', :email => 'test@email.com', :password => 'abc123', :password_confirmation => 'abc123'
  @user.plan = Plan.new :type => :basic, :limit => 1000
  visit("/users/edit")
end

Given /^I am a logged in user with a premium account$/ do
  @user = User.create! :name => 'Test User', :email => 'test@email.com', :password => 'abc123', :password_confirmation => 'abc123'
  @user.plan = Plan.new :type => :paid, :limit => 1000
  visit("/users/edit")
end


When /^I select the 'paid' plan$/ do
  pending
  #choose('paid_plan')
end

When /^I select the 'update' button$/ do
  pending
  #click_button('update')
end

Then /^I should have a premium plan$/ do
  pending
  #@user = User.citeria.id(@user.id)
  #@user.plan.type.should = :paid
end

When /^I select the 'basic' plan$/ do
  pending
  #choose('basic_plan')
end

Then /^I should have a basic plan$/ do
  pending
  #@user = User.citeria.id(@user.id)
  #@user.plan.type.should = :basic
end




