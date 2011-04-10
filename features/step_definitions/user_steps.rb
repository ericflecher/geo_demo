include TestingUserHelper

Given /^an authenticatable user with a "([^"]*)" plan$/ do |plan_type|
  @user = create_new_user("blah", "blah@helloworld.com", plan_type)
end