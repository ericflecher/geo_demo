require 'open-uri'

class Heroku::ResourcesController < ApplicationController

  before_filter :authenticate_basic, :only => [:update, :create, :destroy]
  before_filter :authenticate_sso, :only => [:show]

  def create
    password = User.generate_token('encrypted_password')
    user = User.create!(:email => params[:heroku_id], :password => password, :password_confirmation => password)
    render :json => {:id => user.id, :config => {:ABSTRACTIDENTITY_USERNAME => params[:heroku_id], :ABSTRACTIDENTITY_PASSWORD => password }}
  end

  def destroy
    User.delete(params[:id])
    render :json => "successful removal of service: " + params[:id]
  end

  def show
    session[:user] = params[:id]
    session[:heroku_sso] = true
    response.set_cookie('heroku-nav-data', :value => params['nav-data'], :path => '/')
    @heroku_nav = open('http://nav.heroku.com/v1/providers/header').read
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
