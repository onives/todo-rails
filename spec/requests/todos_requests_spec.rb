require "rails_helper"

RSpec.describe "Todos", type: :request do
    describe '#index' do 
        it 'should return index page' do
            get '/todos'
            expect(response).to have_http_status(:success)
        end
        
    end
end