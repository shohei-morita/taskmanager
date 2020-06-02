require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    @task = create(:task)
    @second_task = create(:second_task)
    @third_task = create(:third_task)
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
        expect(task_list[0]).to have_content 'test3'
        expect(task_list[1]).to have_content 'test_theme2'
        expect(task_list[2]).to have_content 'test_theme1'
      end
    end

    context 'タスクのソートを選択した場合' do
      it 'タスクを終了期限順に並べることができる' do
        visit tasks_path
        click_on '終了期限でソートする'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test_theme1'
        expect(task_list[1]).to have_content 'test_theme2'
        expect(task_list[2]).to have_content 'test3'
      end

      it 'タスクを優先順位順に並べることができる' do
        visit tasks_path
        click_on '優先順位でソートする'
        priority_list = all('.priority_row')
        expect(priority_list[0]).to have_content '高い'
        expect(priority_list[1]).to have_content '普通'
        expect(priority_list[2]).to have_content '低い'
      end
    end

    context '検索をした場合' do
      it 'タイトルで検索できる' do
        visit tasks_path
        fill_in 'theme_search', with: 'theme'
        click_on 'exec_search'
        expect(page).to have_content('theme', count: 2)
      end

      it 'ステータスで検索できる' do
        visit tasks_path
        select '着手中', from: 'status'
        click_on 'exec_search'
        status_list = all('.status_row')
        expect(status_list[0]).to have_content '着手中'
      end

      it 'タイトルとステータスの両方で検索できる' do
        visit tasks_path
        select '未着手', from: 'status'
        fill_in 'theme_search', with: 'theme'
        click_on 'exec_search'
        status_list = all('.status_row')
        expect(status_list[0]).to have_content '未着手'
        expect(status_list[1]).to have_content '未着手'
        expect(page).to have_content('theme', count: 2)
      end
    end

  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'task_theme', with: '源五郎'
        fill_in 'task_content', with: 'これは誰だ'
        fill_in 'time_limit', with: Date.new(2020,6,5)
        select '着手中', from: 'task_status'
        select '高い', from: 'task_priority'
        click_on 'task_post'
        expect(page).to have_content '源五郎'
        expect(page).to have_content 'これは誰だ'
        expect(page).to have_content '2020-06-05'
        expect(page).to have_content '着手中'
        expect(page).to have_content '高い'
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移する' do
         visit tasks_path
         click_on '詳細', match: :first
         expect(current_path).to eq task_path(@third_task.id)
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
