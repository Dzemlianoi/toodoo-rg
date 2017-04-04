class TasksController < ApplicationController
  load_and_authorize_resource

  def index
    render json: @tasks
  end

  def create
    if @task
      render json: @task
    else
      render json: { message: I18n.t('task.error_save') }, status: 200
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: { message: I18n.t('task.error_update') }, status: 200
    end
  end

  def destroy
    if @task.destroy
      render json: @task
    else
      render json: { message: I18n.t('task_list.error_destroy') }, status: 200
    end
  end

  private

  def task_params
    params.permit(:title, :project_id, :deadline, :completed, :priorite)
  end
end
