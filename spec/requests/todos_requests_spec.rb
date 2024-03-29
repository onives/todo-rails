# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  let(:user) { User.create(email: 'olive@gmail.com', password: '123456') }
  before { sign_in user }
  describe '#index' do
    it 'should return index page' do
      get '/todos'
      expect(response).to have_http_status(:success)
    end
    it 'should return list of todos for signed in user' do
      todo = Todo.create(title: 'a title', body: 'a body', user_id: user.id)
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
      todo = Todo.create(title: 'some todo', body: 'some body here', user_id: user.id)
      delete "/todos/#{todo.id}"
      expect(response).to have_http_status(303)
      follow_redirect!
      expect(response).to render_template(:index)
    end
  end

  describe '#update' do
    it 'should display todo edit form' do
      todo = Todo.create(title: 'some todo', body: 'some body here', user_id: user.id)
      get "/todos/#{todo.id}/edit"
      expect(response).to render_template(:edit)
    end
    it 'should update an existing todo' do
      todo = Todo.create(title: 'some todo', body: 'some body here', user_id: user.id)
      patch "/todos/#{todo.id}", params: { todo: { body: 'Changed body' } }
      expect(response).to redirect_to(assigns(:todo))
      follow_redirect!
      expect(response).to render_template(:show)
    end
    it 'should render edit view if update is unsuccessful' do
      todo = Todo.create(title: 'some todo', body: 'some body here', user_id: user.id)
      patch "/todos/#{todo.id}", params: { todo: { body: 'Changed body', title: nil } }
      expect(response).to have_http_status(422)
      expect(response).to render_template(:edit)
      expect(response.body).to include('Validation failed')
    end
  end
end
