# frozen_string_literal: true

# app controller
class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound do |e|
    @error = e.message
    render :not_found, status: :not_found
  end
end
