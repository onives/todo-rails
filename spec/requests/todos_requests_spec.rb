# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  describe '#index' do
    it 'should return index page' do
      get '/todos'
      expect(response).to have_http_status(:success)
    end
    it 'should return list of todos' do
      todo = Todo.create(title: 'a title', body: 'a body')
      get '/todos'
      expect(assigns(:todos)).to include(todo)
    end
  end

  describe '#create' do
    it 'should create a todo and redirect to showing it' do
      post '/todos', params: { todo: { title: 'First Todo', body: 'This is a body!' } }
      expect(response).to redirect_to(assigns(:todo))
      follow_redirect!
      expect(response).to render_template(:show)
    end

    it 'should respond with Unprocessable Content, given a incomplete model parameters' do
      post '/todos', params: { todo: { body: 'Body without a title' } }
      expect(response).to have_http_status(422)
    end
  end

  describe '#new' do
    it 'should display form for creating new todo' do
      get '/todos/new'
      expect(response).to render_template(:new)
    end
  end

  describe '#destroy' do
    it 'should destroy todo' do
      todo = Todo.create(title: 'some todo', body: 'some body here')
      delete "/todos/#{todo.id}"
      expect(Todo.find_by(id: todo.id)).to be_nil
    end
    it 'should destroy and redirect to list of todos' do
      todo = Todo.create(title: 'some todo', body: 'some body here')
      delete "/todos/#{todo.id}"
      follow_redirect!
      # expect(response).to have_http_status(303)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end
end
