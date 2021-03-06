require 'rails_helper'

RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do

  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do

      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'user-name', with: 'sample'
        fill_in 'user-email', with: 'sample@example.com'
        fill_in 'user-pw', with: '0000000'
        fill_in 'user-pwcf', with: '0000000'
        click_on 'sign-up'
        user = User.last
        expect(current_path).to eq user_path(user.id)
      end

      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end

    end
  end

  describe 'セッション機能のテスト' do
    context 'ユーザのデータがありログインしていない場合' do
      it 'ログインをして、マイページに遷移するテスト' do
        user = create(:user)
        login_as(user)
        expect(current_path).to eq user_path(user.id)
      end
    end

    context '一般ユーザーが他人の詳細画面にアクセスした場合' do
      it '詳細画面に遷移するテスト' do
        user = create(:user)
        user2 = create(:user2)
        login_as(user)
        visit user_path(user2.id)
        expect(current_path).to eq tasks_path
      end
    end

    context 'ログアウトリンクをクリックした場合' do
      it 'ログアウトができるテスト' do
        user = create(:user)
        login_as(user)
        click_on 'Logout'
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe '管理画面のテスト' do

    context '管理者が管理画面にアクセスした場合' do
      it 'アクセスができるテスト' do
        admin = create(:admin)
        login_as(admin)
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end
    end

    context '一般ユーザが管理画面にアクセスした場合' do
      it '管理画面にアクセスできないテスト' do
        user = create(:user)
        login_as(user)
        visit admin_users_path
        expect(current_path).to eq tasks_path
        expect(page).to have_content 'あなたは管理者ではありません'
      end
    end

    context '管理者がユーザを新規登録した場合' do
      it '新規ユーザを登録できるテスト' do
        admin = create(:admin)
        login_as(admin)
        visit new_admin_user_path
        fill_in 'new-user-name', with: 'sample'
        fill_in 'new-user-email', with: 'sample@example.com'
        select '一般', from: 'new-user-authority'
        fill_in 'new-user-pw', with: '0000000'
        fill_in 'new-user-pwcf', with: '0000000'
        click_on 'new-user-create'
        expect(page).to have_content 'sample'
        expect(page).to have_content 'sample@example.com'
        expect(page).to have_content '一般'
      end
    end

    context '管理者がユーザの詳細画面にアクセスした場合' do
      it '詳細画面にアクセスできるテスト' do
        user = create(:user)
        admin = create(:admin)
        login_as(admin)
        visit admin_users_path
        click_on 'タスク閲覧', match: :first
        expect(current_path).to eq admin_user_path(user.id)
      end
    end

    context '管理者がユーザの編集画面からユーザを編集した場合' do
      it 'ユーザ情報を編集できるテスト' do
        user = create(:user)
        admin = create(:admin)
        login_as(admin)
        visit admin_users_path
        click_on 'ユーザ編集', match: :first
        fill_in 'edit-user-name', with: 'sample-edited'
        fill_in 'edit-user-email', with: 'sample-edited@example.com'
        select '管理', from: 'edit-user-authority'
        fill_in 'edit-user-pw', with: '0000000'
        fill_in 'edit-user-pwcf', with: '0000000'
        click_on 'new-user-create'
        expect(page).to have_content 'sample-edited'
        expect(page).to have_content 'sample-edited@example.com'
        expect(page).to have_content '管理'
      end
    end

    context '管理者はユーザの削除をした場合' do
      it 'ユーザの削除ができるテスト' do
        user = create(:user)
        admin = create(:admin)
        login_as(admin)
        visit admin_users_path
        click_on 'ユーザ削除', match: :first
        page.accept_confirm
        expect(page).to have_no_content 'sample'
        expect(page).to have_no_content 'sample@example.com'
        expect(page).to have_no_content '一般'
      end
    end
  end
end
