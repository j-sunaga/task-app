require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  let(:task) {create(:task)}

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
       task = create(:task)
       # タスク一覧ページに遷移
       visit tasks_path
       # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
       # have_contentされているか。（含まれているか。）ということをexpectする（確認・期待する）
       expect(page).to have_content 'test_name'
       # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
      # new_task_pathにvisitする（タスク登録ページに遷移する）
      # 1.ここにnew_task_pathにvisitする処理を書く
      visit new_task_path

      # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
      # タスクのタイトルと内容をそれぞれfill_in（入力）する
      # 2.ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
      fill_in "task[name]", with: "Example_Task"
      # 3.ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
      fill_in "task[detail]", with: "Example_Detail"
      select '2020', from: "task[deadline(1i)]"
      select 'March',from: "task[deadline(2i)]"
      select '25',from: "task[deadline(3i)]"
      fill_in "task[status]", with: "Example_Status"
      fill_in "task[priority]", with: "Example_Priority"

      # 「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
      # 4.「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
      click_on 'commit'
      # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
      # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
      # 5.タスク詳細ページに、テストコードで作成したはずのデータ（記述）がhave_contentされているか（含まれているか）を確認（期待）するコードを書く
      expect(page).to have_content 'Example_Task'
      end
    end
  end
  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移する' do
        visit tasks_path(task)
        expect(page).to have_content 'test_name'
       end
     end
  end
end
