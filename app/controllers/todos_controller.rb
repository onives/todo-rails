# frozen_string_literal: true

# Todos controller Class
class TodosController < ApplicationController
  def index
    @todos = Todo.all
  end

  def new
    @todo = Todo.new
  end
end