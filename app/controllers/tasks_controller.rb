# frozen_string_literal: true

class TasksController < ApplicationController
  load_and_authorize_resource

  def index
    render json: @tasks.where(project_id: task_params[:project_id]) and return if task_params.key? :project_id
    render json: { message: I18n.t('errors.task.index'), status: :unprocessable_entity }
  end

  def create
    render json: @task and return if @task.save
    render json: @task.errors, status: :unprocessable_entity
  end

  def update
    render json: @task and return if @task.update(task_params)
    render json: @task.errors, status: :unprocessable_entity
  end

  def destroy
    render json: { deleted: true } and return if @task.destroy
    render json: { message: I18n.t('errors.task.destroy') }, status: :unprocessable_entity
  end

  %w(up down).each do |key|
    define_method("order_#{key}") do
      render json: @task.send("priorite_#{key}")
    end
  end

  private

  def task_params
    params.permit(:title, :project_id, :deadline, :completed, :priorite)
  end
end
