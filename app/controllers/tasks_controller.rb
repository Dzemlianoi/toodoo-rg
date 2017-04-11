# frozen_string_literal: true

class TasksController < ApplicationController
  load_and_authorize_resource

  def index
    render json: @tasks
  end

  def create
    render json: @task and return if @task.save
    render json: { message: I18n.t('errors.task.save') }, status: 200
  end

  def update
    render json: @task and return if @task.update(task_params)
    render json: { message: I18n.t('errors.task.update') }, status: 200
  end

  def destroy
    render json: { nothing: true } and return if @task.destroy
    render json: { message: I18n.t('errors.task.destroy') }, status: 200
  end

  private

  def task_params
    params.permit(:title, :project_id, :deadline, :completed, :priorite)
  end
end
