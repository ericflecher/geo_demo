require 'heroku/kensa/http'

  Heroku::Kensa::HTTP.module_eval do

    def get(path, params={})
      path = "#{path}?" + params.map { |k, v| "#{k}=#{v}" }.join("&") unless params.empty?
      @data[:session].get(path)
      get_code_and_body
    end

    def post(credentials, path, payload=nil)
      request_with_method(:post, get_request_args(credentials, path, payload))
      get_code_and_body
    end

    def put(credentials, path, payload=nil)
      request_with_method(:put, get_request_args(credentials, path, payload))
      get_code_and_body
    end

    def delete(credentials, path, payload=nil)
      request_with_method(:delete, get_request_args(credentials, path, payload))
      get_code_and_body
    end

    protected

    def get_code_and_body
      [@data[:session].response.code.to_i, @data[:session].response.body]
    end

    def request_with_method(method, params)
      @data[:session].send(method, *params)
    end

    def get_request_args(credentials, path, payload=nil)
      user, password = credentials
      [path, get_args(payload)[0],
      {"CONTENT_TYPE" => "application/json",
       "HTTP_AUTHORIZATION" =>
           ActionController::HttpAuthentication::Basic.encode_credentials(user, password)}]
    end

    def get_args(payload)
      [(Yajl::Encoder.encode(payload) if payload),
        {
          :accept => "application/json",
          :content_type => "application/json"
        }
      ].compact
    end

  end