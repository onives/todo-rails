# frozen_string_literal: true

# Todos controller Class
class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: %i[destroy update show edit]

  def index
    @todos = current_user.todos + current_user.todo_collaborations
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

  def edit
    @users = User.all
  end

  def update
    @todo.update!(todo_params)
    update_collaborations(@todo, todo_params[:collaborator_ids])
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
    params.require(:todo).permit(:title, :body, collaborator_ids: [])
  end

  def set_todo
    # find todo from user's todos or those assigned through collaborations
    @todo = current_user.todos.find(params[:id]) ||
            current_user.todo_collaborations.find_by(id: params[:id])
  end

  def update_collaborations(todo, collaborator_ids)
    # Remove existing collaborations not in collaborator_ids
    todo.collaborations.where.not(user_id: collaborator_ids).destroy_all

    # Add new collaborations
    (collaborator_ids - todo.collaborator_ids).each do |collaborator_id|
      Collaboration.create(user_id: collaborator_id, todo_id: todo.id)
    end
  end
end
