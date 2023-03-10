# frozen_string_literal: true

$app_dir = File.expand_path(File.join(__dir__, '..'))
$LOAD_PATH << File.join($app_dir)
$LOAD_PATH << File.join($app_dir, 'lib')
$LOAD_PATH << File.join($app_dir, 'models')

require 'json'
require 'active_record'
require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext/hash'
require 'active_support/core_ext/object'
require 'active_support/core_ext/string'
require 'active_support/number_helper'
require 'slack'

require 'test_bot'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: File.join($app_dir, '..', 'data.sqlite3')
)

require 'application_record'
