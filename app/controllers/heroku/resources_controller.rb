require 'open-uri'

class Heroku::ResourcesController < ApplicationController

  before_filter :authenticate_basic, :only => [:update, :create, :destroy]
  before_filter :authenticate_sso, :only => [:show]


  def create
    password = ActiveSupport::SecureRandom.base64(10)
    user = User.create!(:name => params[:heroku_id],
                        :email => params[:heroku_id],
                        :password => password,
                        :password_confirmation => password)
    user.plan = Plan.new(:type => "basic")
    user.save!
    render :json => {:id => user.id,
                     :config => {:ABSTRACTIDENTITY_USERNAME => params[:heroku_id],
                                 :ABSTRACTIDENTITY_PASSWORD => password}}
  end

  def update
    user = User.first(:conditions => {:id => params[:id]})
    user.plan.type = params[:plan]
    user.save!
    render :json => "ok"
  end

  def destroy
    User.first(:conditions => {:id => params[:id]}).plan.delete
    render :json => "successful removal of service: " + params[:id]
  end

  def show
    session[:user] = params[:id]
    session[:heroku_sso] = true
    cookies["heroku-nav-data"] = {:value => params['nav-data']}
    @heroku_nav = open('http://nav.heroku.com/v1/providers/header').read
    render :template => 'heroku/resources/show'
  end

  def authenticate_basic
    authenticate_or_request_with_http_basic do |id, password|
      id == 'abstractidentity' && password == '4wcRVpdZtcfyGTEJ'
    end
  end

  def authenticate_sso
    pre_token = params[:id] + ':' + GeoDemo::Application.config.heroku_salt + ':' + params[:timestamp]
    token = Digest::SHA1.hexdigest(pre_token).to_s
    if (token != params[:token] || params[:timestamp].to_i < (Time.now - 2*60).to_i)
      render :nothing => true, :status => 403
    end
  end

end
