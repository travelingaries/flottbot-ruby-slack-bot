# frozen_string_literal: true

# CREATE TABLE `users` (
#   `id` INTEGER PRIMARY KEY AUTOINCREMENT,
#   `slack_id` VARCHAR(255) NOT NULL,
#   `created_at` DATETIME NOT NULL,
#   `updated_at` DATETIME NOT NULL,
#   `name` VARCHAR(255)
# );
# CREATE UNIQUE INDEX `slack_id` ON `users` (`slack_id`);
class User < ApplicationRecord
end
