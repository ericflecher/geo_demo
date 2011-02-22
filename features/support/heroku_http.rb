require 'heroku/kensa/http'

  Heroku::Kensa::HTTP.module_eval do
    def request(meth, credentials, path, payload=nil)

      code = nil
      body = nil

      begin
        args = [
          (Yajl::Encoder.encode(payload) if payload),
          {
            :accept => "application/json",
            :content_type => "application/json"
          }
        ].compact

        user, pass = credentials
        if(meth == :post)
          # WTF am I supposed to do this far down??? DJ
          #post('blah', 'blah', 'blah')
        end
  #      body = RestClient::Resource.new(url, user, pass)[path].send(
  #        meth,
  #        *args
  #      ).to_s
  #
        code = 200
      rescue RestClient::ExceptionWithResponse => boom
        code = boom.http_code
        body = boom.http_body
      rescue Errno::ECONNREFUSED
        code = -1
        body = nil
      end

      [code, body]
    end
  end