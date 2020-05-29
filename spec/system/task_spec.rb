require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    @task = create(:task)
    @task = create(:second_task)
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit visit_with_http_auth tasks_path
        expect(page).to have_content 'test_theme1'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test_theme2'
        expect(task_list[1]).to have_content 'test_theme1'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'task_theme', with: '源五郎'
        fill_in 'task_content', with: 'これは誰だ'
        click_on 'task_post'
        expect(page).to have_content '源五郎', 'これは誰だ'
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移する' do
         visit tasks_path
         click_on '詳細', match: :first
         expect(current_path).to eq task_path(@task.id)
     end
    end
  end

  private
  def visit_with_http_auth(path)
    username = 'guest_user'
    password = 'guest_password'
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end

end
