# frozen_string_literal: true

class CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    render json: @comments
  end

  def create
    render json: @comment and return if @comment.save
    render json: @comment.errors, status: :unprocessable_entity
  end

  def update
    render json: @comment and return if @comment.update(comment_params)
    render json: @comment.errors, status: 200
  end

  def destroy
    render json: { deleted: true } and return if @comment.destroy
    render json: { message: I18n.t('errors.comment.destroy') }, status: :unprocessable_entity
  end

  private

  def comment_params
    params.permit(:comment_text, :task_id)
  end
end
