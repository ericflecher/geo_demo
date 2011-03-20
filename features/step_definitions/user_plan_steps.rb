When /^a user creates a new account$/ do
  @user = User.create! :name => 'Test User', :email => 'test@email.com', :password => 'abc123', :password_confirmation => 'abc123'
  @user.plan = Plan.create
end

Then /^a new plan should be created for them$/ do
  plan_id = @user.plan
  plan_id.should_not =~ nil
end