require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { create(:user) }
  let!(:label) { create(:label) }
  let!(:second_label) { create(:label) }
  let!(:task) { create(:task, user: user) }
  let!(:second_task) { create(:task, :status_priority, user: user) }
  let!(:task_label) { create(:task_label, task: task, label: label) }
  let!(:second_task_label) { create(:task_label, task: second_task, label: second_label) }


  before do
    login_as user
  end

  describe 'タスク一覧画面' do

    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit tasks_path
        expect(page).to have_content task.theme
      end
    end

    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        visit tasks_path
        begin
          task_list = all('.task_row')
          expect(task_list[0]).to have_content second_task.theme
          expect(task_list[1]).to have_content task.theme
        rescue Selenium::WebDriver::Error::StaleElementReferenceError
          sleep 1
          retry
        end
      end
    end

    context 'タスクのソートを選択した場合' do
      it 'タスクを終了期限順に並べることができる' do
        visit tasks_path
        click_on '終了期限でソート'
        begin
        task_list = all('.task_row')
          expect(task_list[0]).to have_content task.theme
          expect(task_list[1]).to have_content second_task.theme
        rescue Selenium::WebDriver::Error::StaleElementReferenceError
          sleep 1
          retry
        end
      end
    end

      it 'タスクを優先順位順に並べることができる' do
        visit tasks_path
        click_on '優先順位でソート'
        begin
          priority_list = all('.priority_row')
          expect(priority_list[0]).to have_content '普通'
          expect(priority_list[1]).to have_content '低い'
        rescue Selenium::WebDriver::Error::StaleElementReferenceError
          sleep 1
          retry
        end
      end

    context '検索をした場合' do
      it 'タイトルで検索できる' do
        visit tasks_path
        fill_in 'theme_search', with: task.theme
        click_on 'exec_search'
        expect(page).to have_content( task.theme, count: 2)
      end

      it 'ステータスで検索できる' do
        visit tasks_path
        select '未着手', from: 'status'
        click_on 'exec_search'
        begin
          status_list = all('.status_row')
          expect(status_list[0]).to have_content '未着手'
        rescue Selenium::WebDriver::Error::StaleElementReferenceError
          sleep 1
          retry
        end
      end

      it 'ラベルで検索できる' do
        visit tasks_path
        select label.label, from: 'label_ids'
        click_on 'exec_search'
        begin
          label_list = all('.label_row')
            expect(label_list[0]).to have_content label.label
        rescue Selenium::WebDriver::Error::StaleElementReferenceError
          sleep 1
          retry
        end
      end

      it 'タイトルとステータスの両方で検索できる' do
        visit tasks_path
        select '未着手', from: 'status'
        fill_in 'theme_search', with: task.theme
        click_on 'exec_search'
        begin
          status_list = all('.status_row')
          expect(status_list[0]).to have_content '未着手'
          expect(page).to have_content(task.theme, count: 2)
        rescue Selenium::WebDriver::Error::StaleElementReferenceError
          sleep 1
          retry
        end
      end

      it 'タイトルとラベルの両方で検索できる' do
        visit tasks_path
        select label.label, from: 'label_ids'
        fill_in 'theme_search', with: task.theme
        click_on 'exec_search'
        begin
          label_list = all('.label_row')
          expect(label_list[0]).to have_content label.label
          expect(page).to have_content(task.theme, count: 1)
        rescue Selenium::WebDriver::Error::StaleElementReferenceError
          sleep 1
          retry
        end
      end

      it 'ステータスとラベルの両方で検索できる' do
        visit tasks_path
        select label.label, from: 'label_ids'
        select '未着手', from: 'status'
        fill_in 'theme_search', with: task.theme
        click_on 'exec_search'
        begin
          label_list = all('.label_row')
        rescue Selenium::WebDriver::Error::StaleElementReferenceError
          sleep 1
          retry
        end
      end

      it 'タイトルとステータスとラベルのすべて両方で検索できる' do
        visit tasks_path
        select label.label, from: 'label_ids'
        select '未着手', from: 'status'
        expect(page).to have_content(task.theme, count: 1)
        click_on 'exec_search'
        begin
          label_list = all('.label_row')
        rescue Selenium::WebDriver::Error::StaleElementReferenceError
          sleep 1
          retry
        end
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
        check label.label
        click_on 'task_post'
        expect(page).to have_content '源五郎'
        expect(page).to have_content 'これは誰だ'
        expect(page).to have_content '2020-06-05'
        expect(page).to have_content '着手中'
        expect(page).to have_content '高い'
        expect(page).to have_content label.label
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移する' do
         visit tasks_path
         click_on '詳細', match: :first
         expect(current_path).to eq task_path(second_task.id)
     end
    end
  end

  describe 'タスク編集機能' do
    context '任意のタスク編集画面に遷移した場合' do
      it 'タスク情報を編集できる' do
        visit tasks_path
        click_on '編集', match: :first
        fill_in 'task_theme', with: 'task-sample100'
        fill_in 'task_content', with: 'task-content100'
        fill_in 'time_limit', with: Date.new(2020,4,13)
        select '完了', from: 'task_status'
        select '高い', from: 'task_priority'
        check second_label.label
        click_on 'task_post'
        expect(page).to have_content 'task-sample100'
        expect(page).to have_content 'task-content100'
        expect(page).to have_content '2020-04-13'
        expect(page).to have_content '完了'
        expect(page).to have_content '高い'
        expect(page).to have_content second_label.label
      end
    end
  end

  describe 'ラベル機能' do
    context 'ユーザがラベルを作成した場合' do
      it '投稿時の選択肢に自作ラベルを表示できる' do
        visit new_label_path
        fill_in 'label_create', with: 'label-sample1'
        click_on 'post'
        visit new_task_path
        expect(page).to have_content 'label-sample1'
      end

      it 'ラベルを編集できる' do
        visit labels_path
        click_on '編集', match: :first
        fill_in 'label_create', with: 'label-sample2'
        click_on 'post'
        expect(page).to have_content 'label-sample2'
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
