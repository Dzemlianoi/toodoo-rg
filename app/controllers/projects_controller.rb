# frozen_string_literal: true

class ProjectsController < ApplicationController
  load_and_authorize_resource through: :current_user

  def index
    render json: @projects
  end

  def create
    render json: @project and return if @project.save
    render json: @project.errors, status: :unprocessable_entity
  end

  def update
    render json: @project and return if @project.update(project_params)
    render json: @project.errors, status: :unprocessable_entity
  end

  def destroy
    render json: { deleted: true } and return if @project.destroy
    render json: { message: I18n.t('errors.project.destroy') }, status: 200
  end

  private

  def project_params
    params.permit(:title, :user_id)
  end
end
