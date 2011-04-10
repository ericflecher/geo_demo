module TestingUserHelper
  def create_new_user(name, email, plan_type)
    password = ActiveSupport::SecureRandom.base64(10)
    user = User.create!(:name => name,
                         :email => email,
                         :password => password,
                         :password_confirmation => password)
    user.authentication_token = ActiveSupport::SecureRandom.base64(20)
    user.plan = Plan.new(:type => plan_type)
    user.save!
    user
  end
end