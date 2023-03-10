# frozen_string_literal: true

module TestBot
  class Message
    attr_accessor :args, :options

    def initialize(args = [], options = {})
      @args = args
      @options = options
    end

    def slack_id
      sid = ENV['SLACK_ID']

      unless defined?(@_user)
        user = TestBot.slack.user_info(sid)
        name = user[:profile][:display_name]
        @_user = User.find_by_slack_id(sid)
        if @_user.present?
          @_user.name = name
        else
          @_user = User.new(slack_id: sid, name: name)
        end
        @_user.save!
      end

      sid
    end

    def channel
      ENV['CHANNEL']
    end

    def username
      ENV['USERNAME']
    end

    def user
      slack_id
      @_user
    end

    def run
      raise NotImplementedError
    end

    def parse_args(message_regex)
      raw_input = args.join(' ')
      m = raw_input.match(message_regex)
      raise MessageNotMatched if m.blank?

      raw_input.partition(m[0]).last.strip.split(' ')
    end

    def parse_url(message)
      if message.start_with?('<')
        m = message.match(/<([^|]+)\|.*>/)
        if m.present?
          m[1]
        else
          message.match(/<(.+)>/)[1]
        end
      else
        message
      end
    end

    def format_code(text)
      "```#{text}```"
    end

    # @param method, <:get, :post, :put, :delete>
    def request_api(method, url, params: {}, _limit: 1)
      raise ApiRequestError, 'too many redirects' if _limit.negative?

      uri = URI(url)
      uri.query = URI.encode_www_form(params) if params.present?

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.instance_of?(URI::HTTPS)

      req = case method
            when :get then Net::HTTP::Get.new(uri)
            when :post then Net::HTTP::Post.new(uri)
            when :put then Net::HTTP::Put.new(uri)
            when :delete then Net::HTTP::Delete.new(uri)
            else raise ApiRequestError, "method #{method} not supported"
            end
      req['Content-Type'] = 'application/json'

      res = http.request(req)

      if res.is_a?(Net::HTTPRedirection)
        loc = res['location']
        raise ApiRequestError, 'invalid redirect' unless loc.present?

        uri = URI(loc)

        request(:get, uri, params, _limit: _limit - 1)
      else
        status = res.code.to_i
        body = begin
          JSON.parse(res.body).with_indifferent_access
        rescue JSON::ParserError
          raise ApiRequestError, "invalid response: #{sc}: #{res.body}"
        end

        [status, body]
      end
    end
  end
end
