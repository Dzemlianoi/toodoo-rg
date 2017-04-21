# frozen_string_literal: true

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let!(:task) { create(:task, project: project) }

  before do
    allow(controller).to receive(:current_user) { user }
  end

  describe 'GET index' do
    before { get :index, format: :json }

    it { expect(response).to have_http_status(200) }

    it 'assign @task from current user' do
      expect(assigns(:tasks)).to eq project.tasks
    end
  end

  describe 'POST create' do
    context 'success' do
      let(:request) { post :create, format: :json, params: { title: 'My task', project_id: project.id } }

      it 'assign @tasks with new params' do
        request
        expect(assigns(:task).title).to eq 'My task'
      end

      it 'response with 200 code' do
        request
        expect(response.status).to eq 200
      end

      it 'changes tasks count' do
        expect { request }.to change { Task.count }.by(1)
      end
    end

    context 'error' do
      let(:request) { post :create, format: :json, params: { project_id: project.id } }

      it 'response with 200 code' do
        request
        expect(response.status).to eq 200
      end

      it 'task cannot be initialized' do
        request
        expect(assigns(:task)).not_to be_valid
      end

      it 'dont changes task count' do
        expect { request }.not_to change { Project.count }
      end
    end
  end

  describe 'PUT update' do
    let(:title_updated) { 'title' }
    before do
      put :update, format: :json, params: { id: task.id, title: title_updated }
    end

    it 'update task' do
      expect(assigns(:task).title).to eq title_updated
    end
  end

  describe 'DELETE destroy' do
    let(:request) { post :destroy, format: :json, params: { id: task.id } }

    it 'changes task count' do
      expect { request }.to change { Task.count }.by(-1)
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
