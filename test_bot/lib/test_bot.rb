# frozen_string_literal: true

require 'logger'
require 'test_bot/message'
require 'test_bot/slack_client'

module TestBot
  class MessageNotMatched < StandardError; end
  class ApiRequestError < StandardError; end

  def self.run(message, args = [], options = {})
    logger = Logger.new('log/test_bot-rb.log')
    logger.level = Logger::DEBUG
    logger.datetime_format = '%Y-%m-%d %H:%M:%S'

    logger.info "Message: #{message.inspect}"
    logger.info " args: #{args.inspect}"
    logger.info " options: #{options.inspect}"

    options[:logger] = logger

    begin
      require File.join('messages', message)
      message.camelize.constantize.new(args, options).run

      logger.info 'complete'
    rescue StandardError => e
      logger.error e.inspect
      logger.error e.backtrace.join("\n")
    end
  end

  def self.slack
    @slack ||= SlackClient.new(ENV['SLACK_TOKEN'])
  end
end
