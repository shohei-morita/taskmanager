require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  before do
    @user = create(:user)
  end

  context 'バリデーション機能テスト' do
    it 'titleが空ならバリデーションが通らない' do
      task = @user.tasks.new(theme: '', content: '失敗テスト')
      expect(task).to be_invalid
    end

    it 'contentが空ならバリデーションが通らない' do
      task = @user.tasks.new(theme: '失敗テスト', content: '')
      expect(task).to be_invalid
    end

    it 'titleとcontetに内容が記載されていればバリデーションが通る' do
      task = @user.tasks.new(theme: '通過テスト', content: '通過テスト')
      expect(task).to be_valid
    end
  end

  context 'scopeメソッドで検索をした場合' do
    before do
      @user.tasks.create(theme: "task", content: "sample_task", status: 1)
      @user.tasks.create(theme: "task", content: "sample_task2", status: 1)
      @user.tasks.create(theme: "sample", content: "sample_task", status: 2)
      @user.tasks.create(theme: "rake", content: "sample_task", status: 2)
    end
    it 'scopeメソッドでタイトル検索ができる' do
      expect(Task.search_theme('task').count).to eq 2
    end

    it 'scopeメソッドでステータス検索ができる' do
      expect(Task.search_status(2).count).to eq 2
    end

    it 'scopeメソッドでタイトル検索とステータス検索の両方ができる' do
      expect(Task.search_theme('task').search_status(1).count).to eq 2
    end
  end
end
