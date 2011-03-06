require 'spec_helper'

describe User do
  it "should have an associated plan" do
    user = User.create! :name => 'Test User', :email => 'test@email.com', :password => 'abc123', :password_confirmation => 'abc123'
  end
end
