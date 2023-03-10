# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_create { self.created_at = DateTime.current }
  before_save { self.updated_at = DateTime.current }
end

require 'user'
require 'restaurant'
