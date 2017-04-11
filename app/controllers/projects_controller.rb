# frozen_string_literal: true

class ProjectsController < ApplicationController
  load_and_authorize_resource

  def index
    render json: @projects
  end

  def create
    render json: @project and return if @project.save
    render json: { message: I18n.t('errors.project.save') }, status: 200
  end

  def update
    render json: @project and return if @project.update(project_params)
    render json: { message: I18n.t('errors.project.update') }, status: 200
  end

  def destroy
    render json: { nothing: true } and return if @project.destroy
    render json: { message: I18n.t('errors.project.destroy') }, status: 200
  end

  private

  def project_params
    params.permit(:title, :user_id)
  end
end
