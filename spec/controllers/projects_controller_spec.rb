# frozen_string_literal: true

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create(:user) }
  let!(:project) { create(:project, user: user) }

  before do
    allow(controller).to receive(:current_user) { user }
  end

  describe 'GET index' do
    before { get :index, format: :json }

    it { expect(response).to have_http_status(200) }
    it 'assign @projects from current user' do
      expect(assigns(:projects)).to eq user.projects
    end
  end

  describe 'POST create' do
    context 'success' do
      let(:request) { post :create, format: :json, params: { title: 'text', user_id: user.id } }

      it 'assign @project with new params' do
        request
        expect(assigns(:project).title).to eq 'text'
      end

      it 'response with 200 code' do
        request
        expect(response.status).to eq 200
      end

      it 'changes project count' do
        expect { request }.to change { Project.count }.by(1)
      end
    end

    context 'error' do
      let(:request) { post :create, format: :json }

      it 'response with 200 code' do
        request
        expect(response.status).to eq 200
      end

      it 'project cannot be initialized' do
        request
        expect(assigns(:project)).not_to be_valid
      end

      it 'dont changes project count' do
        expect { request }.not_to change { Project.count }
      end
    end
  end

  describe 'PUT update' do
    let(:title_updated) { 'title' }
    before do
      put :update, format: :json, params: { id: project.id, title: title_updated }
    end

    it 'update project' do
      expect(assigns(:project).title).to eq title_updated
    end
  end

  describe 'DELETE destroy' do
    let(:request) { post :destroy, format: :json, params: { id: project.id } }

    it 'changes project count' do
      expect { request }.to change { Project.count }.by(-1)
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
