require "heroku/kensa"
require "heroku/kensa/check"
require "heroku/kensa/client"
require "heroku/kensa/manifest"
require "heroku/kensa/sso"


When /^running the kensa provision test$/ do
  @client = Heroku::Kensa::Client.new(["provision"], {:filename => "addon-manifest.json", :session => self})
end

Then /^the test should run with no fails$/ do
  @client.test
end
