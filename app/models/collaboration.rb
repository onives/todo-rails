# frozen_string_literal: true

# Collaboration Model
class Collaboration < ApplicationRecord
  belongs_to :user
  belongs_to :todo
end
