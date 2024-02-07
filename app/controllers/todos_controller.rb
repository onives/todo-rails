# frozen_string_literal: true

# Todos controller Class
class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: %i[destroy update show edit]

  def index
    @todos = current_user.todos
  end

  def new
    @todo = current_user.todos.new
  end

  def show; end

  def create
    @todo = current_user.todos.new(todo_params)
    if @todo.save
      redirect_to @todo
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @todo.update!(todo_params)
    redirect_to @todo
  rescue StandardError => e
    @error = e.message
    render :edit, status: :unprocessable_entity
  end

  def destroy
    @todo.destroy

    redirect_to todos_path, status: :see_other
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :body)
  end

  def set_todo
    @todo = current_user.todos.find(params[:id])
    # rescue ActiveRecord::RecordNotFound => e
    #   @error = e.message
    #   render :not_found, status: :not_found
  end
end
