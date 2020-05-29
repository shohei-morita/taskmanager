require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(theme: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end
  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(theme: '失敗テスト', content: '')
    expect(task).not_to be_valid
  end
  it 'titleとcontetに内容が記載されていればバリデーションが通る' do
    task = Task.new(theme: '通過テスト', content: '通過テスト')
    expect(task).to be_valid
  end

end
