When /^a user creates a new account$/ do
  user = User.create! :name => 'Test User', :email => 'test@email.com', :password => 'abc123', :password_confirmation => 'abc123'
  puts user.name
end

Then /^a new plan should be created for them$/ do

end