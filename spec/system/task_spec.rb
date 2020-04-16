require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  let!(:user){create(:user)}
  let!(:task){create(:task,user:user)}

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        act_as user do
          visit tasks_path
          expect(page).to have_content "#{task.name}"
        end
      end
    end
    context '複数のタスクを作成した場合' do
      let!(:new_task){create(:task, name: 'new_task',detail: 'new_task',user:user)}
      it 'タスクが作成日時の降順に並んでいる' do
        act_as user do
          visit tasks_path
          task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
          expect(task_list[0]).to have_content 'new_task'
          expect(task_list[1]).to have_content "#{task.name}"
        end
      end
    end
    context '終了期限でソートをクリックした場合' do
      let!(:old_task){create(:task,:old, name:'old_task',detail: 'old_task',user:user)}
      it 'タスクが終了日時のソートで並んでいる' do
        act_as user do
          visit tasks_path
          click_link '終了期限でソートする'
          task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
          expect(task_list[0]).to have_content 'old_task'
          expect(task_list[1]).to have_content "#{task.name}"
        end
      end
    end
    context '優先順位でソートをクリックした場合' do
      let!(:high_task){create(:task,name:'high_task',detail: 'high_task',priority: 'high',user:user)}
      it 'タスクが優先順位の高いソートで並んでいる' do
        act_as user do
          visit tasks_path
          click_link '優先順位でソートする'
          task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
          expect(task_list[0]).to have_content 'high_task'
          expect(task_list[1]).to have_content "#{task.name}"
        end
      end
    end
    context '検索をした場合' do
      let!(:tasks){create_list(:task, 2, status: 'working',user:user)}
      it "タイトルで検索できる" do
        act_as user do
          visit tasks_path
          fill_in "name", with: "#{tasks[0].name}"
          click_on 'commit'
          expect(page).to have_content "#{tasks[0].name}"
          expect(page).to_not have_content "#{tasks[1].name}"
        end
      end
      it "ステータスで検索できる" do
        act_as user do
          visit tasks_path
          select '着手中',from: "status"
          click_on 'commit'
          expect(page).to have_content 'task_9'
          expect(page).to have_content 'task_10'
        end
      end
      it "タスク名とステータスで検索できる" do
        act_as user do
          visit tasks_path
          fill_in "name", with: "12"
          select '着手中',from: "status"
          click_on 'commit'
          expect(page).to have_content 'task_12'
          expect(page).to_not have_content 'task_13'
        end
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        act_as user do
          visit new_task_path
          fill_in "task[name]", with: "Example_Task"
          fill_in "task[detail]", with: "Example_Detail"
          fill_in "task[deadline]", with: 1.month.ago
          select '未着手',from: "task[status]"
          select '低',from: "task[priority]"
          click_on 'commit'
          expect(page).to have_content 'Example_Detail'
        end
      end
    end
  end
  describe 'タスク詳細画面' do
    let!(:task){create(:task,user:user)}
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移する' do
        act_as user do
          visit tasks_path(task)
          expect(page).to have_content 'task'
        end
       end
     end
  end
  describe 'ラベル管理機能' do
    let!(:label){create(:label,user:user)}
    context 'ラベルを登録した場合' do
      it '作成済みのラベルが一覧画面に表示される' do
        act_as user do
          visit labels_path
          expect(page).to have_content "#{label.name}"
        end
      end
    end
    context 'タスクにラベルを紐付けた場合' do
      let!(:tasks){create_list(:task, 2 ,user:user)}
      it "該当タスクが検索できる" do
        act_as user do
          visit tasks_path
          select "#{tasks[0].labels.first.name}",from: "label"
          click_on 'commit'
          expect(page).to have_content "#{tasks[0].name}"
          expect(page).to have_content "#{tasks[0].labels.first.name}"
        end
      end
    end
  end
  describe 'ラベル登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        act_as user do
          visit new_label_path
          fill_in "label[name]", with: "Example_Label"
          click_on 'commit'
          expect(first('.form-control').value).to eq 'Example_Label'
        end
      end
    end
  end
  describe 'ラベル詳細画面' do
    let!(:label){create(:label,user:user)}
    context '任意のラベル詳細画面に遷移した場合' do
      it '該当ラベルの内容が表示されたページに遷移する' do
        act_as user do
          visit labels_path(label)
          expect(page).to have_content "#{label.name}"
        end
      end
    end
  end
end
