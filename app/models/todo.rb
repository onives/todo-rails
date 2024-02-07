# frozen_string_literal: true

# A task to remember to do later
class Todo < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
end
