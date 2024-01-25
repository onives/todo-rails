# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  describe '#index' do
    it 'should return index page' do
      get '/todos'
      expect(response).to have_http_status(:success)
    end
    it 'should return list of todos' do
      todo = Todo.create
      get '/todos'
      expect(assigns(:todos)).to include(todo)
    end
  end

  describe '#create' do
    it 'should create a todo' do
      get '/todos/new'
      expect(response).to render_template(:new)
      # post '/todos', params: { todo: { title: 'First Todo', body: 'This is a body!' } }
      # expect(response).to render_template(:show)
      # expect(assigns(:todos)).to include(todo)
    end
  end
end
