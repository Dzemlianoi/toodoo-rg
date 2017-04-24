# frozen_string_literal: true

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project) }
  let!(:comment) { create(:comment, task: task) }

  before do
    allow(controller).to receive(:current_user) { user }
  end

  describe 'GET index' do
    before { get :index, format: :json }

    it { expect(response).to have_http_status(200) }

    it 'assign @comments from current user' do
      expect(assigns(:comments)).to eq task.comments
    end
  end

  describe 'POST create' do
    context 'success' do
      let(:request) { post :create, format: :json, params: { comment_text: 'Comment', task_id: task.id } }

      it 'assign @comments with new params' do
        request
        expect(assigns(:comment).comment_text).to eq 'Comment'
      end

      it 'response with 200 code' do
        request
        expect(response.status).to eq 200
      end

      it 'changes comment count' do
        expect { request }.to change { Comment.count }.by(1)
      end
    end

    context 'error' do
      let(:request) { post :create, format: :json, params: { task_id: task.id } }

      it 'response with 422 code' do
        request
        expect(response.status).to eq 422
      end

      it 'task cannot be initialized' do
        request
        expect(assigns(:comment)).not_to be_valid
      end

      it 'dont changes comment count' do
        expect { request }.not_to change { Comment.count }
      end
    end
  end

  describe 'PUT update' do
    let(:comment_updated) { 'new comment' }
    before do
      put :update, format: :json, params: { id: comment.id, comment_text: comment_updated }
    end

    it 'update comment' do
      expect(assigns(:comment).comment_text).to eq comment_updated
    end
  end

  describe 'DELETE destroy' do
    let(:request) { post :destroy, format: :json, params: { id: comment.id } }

    it 'changes comment count' do
      expect { request }.to change { Comment.count }.by(-1)
    end
  end

  before do
    allow(controller).to receive(:current_user) { nil }
  end

  describe 'check unauthorized user' do
    it { expect(get :index, format: :json).to have_http_status(401) }
    it { expect(post :create, format: :json).to have_http_status(401) }
    it { expect(patch :update, format: :json).to have_http_status(401) }
    it { expect(delete :destroy, format: :json).to have_http_status(401) }
  end
end
