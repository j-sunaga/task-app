require 'rails_helper'

RSpec.describe 'ユーザ管理機能', type: :system do

  let!(:admin){create(:admin_user)}
  let!(:user){create(:user)}

  describe 'ユーザ登録機能' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
      visit new_user_path
      fill_in "user[name]", with: "test_1"
      fill_in "user[email]", with: "test_1@test.com"
      fill_in "user[password]", with: "000000"
      fill_in "user[password_confirmation]", with: "000000"
      click_on 'commit'
      expect(page).to have_content 'test_1'
      end
    end
    context 'ログインしていない状態でタスク画面に飛ぼうとした場合' do
      it 'ログイン画面が表示される' do
        visit tasks_path
        expect(page).to have_content 'ログインが必要です'
      end
    end
  end
  describe 'セッション機能' do
    context '登録済みのユーザ情報でログインができる' do
      it 'ログイン後,userページが表示される' do
        act_as user do
          expect(page).to have_content "#{user.name}"
        end
      end
    end
    context '一般ユーザが他のユーザページアクセスした場合' do
      let!(:user_1){create(:user)}
      it 'タスク一覧ページに飛ぶ' do
        act_as user do
          visit user_path(user_1)
          expect(page).to have_content "タスク一覧"
        end
      end
    end
    context 'ログアウト機能' do
      it "ログアウトをクリックするとログインページ表示される" do
        act_as user do
        end
      end
    end
  end
  describe '管理画面のテスト' do
    context '管理者でログインした場合' do
      it 'ユーザ一覧画面が表示される' do
        act_as admin do
          visit admin_users_path
          click_link '名前でソートする'
          user_list = all('.user_row')
          expect(user_list[0]).to have_content "#{admin.name}"
          expect(user_list[1]).to have_content "#{user.name}"
        end
      end
    end
    context '一般ユーザでログインした場合' do
      it '管理画面に飛ぼうとするとタスク画面に飛ぶ' do
        act_as user do
          visit admin_users_path
          expect(page).to have_content "タスク一覧"
        end
      end
    end
    context '管理者はユーザの新規登録ができる' do
      it '管理者アカウントでログイン後、ユーザ登録ができる' do
        act_as admin do
          visit admin_users_path
          click_link 'ユーザの登録'
          fill_in "user[name]", with: "test_user"
          fill_in "user[email]", with: "test_user@test.com"
          select '一般ユーザ',from: "user[admin]"
          fill_in "user[password]", with: "000000"
          fill_in "user[password_confirmation]", with: "000000"
          click_on 'commit'
          visit admin_users_path
          expect(page).to have_content "test_user"
        end
      end
    end
    context '管理者はユーザの詳細画面にアクセスできる' do
      it 'ユーザの詳細画面でユーザ名が表示される' do
        act_as admin do
          visit admin_users_path
          visit admin_user_path(user)
          expect(first('.form-control').value).to eq "#{user.name}"
        end
      end
    end
    context '管理者はユーザ情報を編集できる' do
      it '編集ページ に飛び、情報を更新される' do
        act_as admin do
          visit admin_users_path
          visit edit_admin_user_path(user)
          fill_in "user[name]", with: "test_user"
          fill_in "user[password]", with: "000000"
          fill_in "user[password_confirmation]", with: "000000"
          click_on 'commit'
          visit admin_users_path
          expect(page).to have_content "test_user"
        end
      end
    end
    context '管理者はユーザを削除できる' do
      it '削除をクリックするとuser情報が表示されない' do
        act_as admin do
          visit admin_users_path
          find_by_id('1').click_link
          page.accept_confirm "本当に削除してもよろしいですか？"
          visit admin_users_path
          expect(page).not_to have_content "#{user.name}"
        end
      end
    end
  end
end
