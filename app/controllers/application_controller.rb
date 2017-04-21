# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  include DeviseTokenAuth::Concerns::SetUserByToken

  respond_to :json

  rescue_from CanCan::AccessDenied do |exception|
    render status: 401, json: { error: exception.message }
  end
end
