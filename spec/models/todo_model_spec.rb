# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Todo, type: :model do
  it 'should save a todo' do
    subject = Todo.new(body: 'a body', title: 'a title')
    expect(subject).to be_valid
  end

  it 'should require a body' do
    subject = Todo.new(body: nil, title: 'a title')
    expect(subject).to_not be_valid
  end

  it 'should require a title' do
    subject = Todo.new(body: 'a body', title: nil)
    expect(subject).to_not be_valid
  end

  it 'should destroy todo' do
    todo = Todo.new(title: 'fake title', body: 'some fake body here!')
    assert todo.destroy, 'Failed to delete todo'
  end
  it 'should update todo' do
    subject = Todo.new(title: 'fake title', body: 'some fake body here!')
    subject.update(body: 'updated body')
    expect(subject.body).to eql('updated body')
  end
end
