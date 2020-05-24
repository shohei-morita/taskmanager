require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        task = create(:task, theme: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
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
         task = create(:task, theme: "task")
         visit tasks_path
         click_on '詳細'
         expect(current_path).to eq task_path(task.id)
     end
    end
  end

end
