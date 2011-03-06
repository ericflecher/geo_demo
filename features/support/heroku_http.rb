require 'heroku/kensa/http'

  Heroku::Kensa::HTTP.module_eval do

    def get(path, params={})
      path = "#{path}?" + params.map { |k, v| "#{k}=#{v}" }.join("&") unless params.empty?
      @data[:session].get path
      [@data[:session].response.code.to_i, @data[:session].response.body]
    end

    def post(credentials, path, payload=nil)
      @data[:session].post(*get_request_args(credentials, path, payload))
      [@data[:session].response.code.to_i, @data[:session].response.body]
    end

    def put(credentials, path, payload=nil)
      @data[:session].put(*get_request_args(credentials, path, payload))
      [@data[:session].response.code.to_i, @data[:session].response.body]
    end

    def delete(credentials, path, payload=nil)
      @data[:session].delete(*get_request_args(credentials, path, payload))
      [@data[:session].response.code.to_i, @data[:session].response.body]
    end

    protected

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