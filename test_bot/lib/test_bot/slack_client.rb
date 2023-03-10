# frozen_string_literal: true

module TestBot
  class SlackClient
    attr_reader :client

    def initialize(token)
      @client = ::Slack::Web::Client.new(token: token)
      @client.auth_test
    end

    # @param slack_id [String]
    def user_info(slack_id)
      client.users_info(user: slack_id)['user'].with_indifferent_access
    end

    def post_ephemeral(**args)
      client.chat_postEphemeral(**args)
    end
  end
end
