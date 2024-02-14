# frozen_string_literal: true

# this is a user model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # has_many :todos, through: :collaborations, dependent: :destroy
  has_many :todos, dependent: :destroy
  has_many :collaborations, dependent: :destroy
  has_many :todo_collaborations, through: :collaborations, source: :todo
end
