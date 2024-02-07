# frozen_string_literal: true

# Todos controller Class
class TodosController < ApplicationController
  before_action :authenticate_user!

  def index
    @todos = current_user.todos
  end

  def new
    @todo = current_user.todos.new
  end

  def show
    @todo = current_user.todos.find(params[:id])
  end

  def create
    @todo = current_user.todos.new(todo_params)
    if @todo.save
      redirect_to @todo
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @todo = current_user.todos.find(params[:id])
  end

  def update
    @todo = current_user.todos.find(params[:id])

    begin
      @todo.update!(todo_params)
      redirect_to @todo
    rescue StandardError => e
      @error = e.message
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo = current_user.todos.find(params[:id])
    @todo.destroy

    redirect_to todos_path, status: :see_other
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :body)
  end
end
