# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  include DeviseTokenAuth::Concerns::SetUserByToken

  respond_to :json
end
