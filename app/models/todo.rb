# frozen_string_literal: true

# A task to remember to do later
class Todo < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  has_many :collaborations, dependent: :destroy
  has_many :collaborators, through: :collaborations, source: :user
  accepts_nested_attributes_for :collaborations
end
