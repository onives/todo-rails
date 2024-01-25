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
end
