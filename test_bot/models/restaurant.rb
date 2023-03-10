# frozen_string_literal: true

# CREATE TABLE `restaurants` (
#   `id` INTEGER PRIMARY KEY AUTOINCREMENT,
#   `name` VARCHAR(255) NOT NULL UNIQUE,
#   `created_at` DATETIME NOT NULL,
#   `updated_at` DATETIME NOT NULL
# );
# CREATE INDEX `name` ON `restaurants` (`name`);
class Restaurant < ApplicationRecord
end
