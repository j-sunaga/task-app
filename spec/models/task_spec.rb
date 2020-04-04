require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do
  it 'nameが空ならバリデーションが通らない' do
    task = Task.new(detail: "task_detail",deadline: 1.month.ago, status: :waiting, priority: :low)
    expect(task).not_to be_valid
  end
  it 'detailが空ならバリデーションが通らない' do
    # ここに内容を記載する
    task = Task.new(name: "task_test",deadline: 1.month.ago, status: :waiting, priority: :low)
    expect(task).not_to be_valid
  end
  it 'deadlineが空ならバリデーションが通らない' do
    # ここに内容を記載する
    task = Task.new(name: "task_test", detail: "task_detail",status: :waiting, priority: :low)
    expect(task).not_to be_valid
  end
  it 'statusが空ならバリデーションが通らない' do
    # ここに内容を記載する
    task = Task.new(name: "task_test", detail: "task_detail",deadline: 1.month.ago, priority: :low)
    expect(task).not_to be_valid
  end
  it 'priorityが空ならバリデーションが通らない' do
    # ここに内容を記載する
    task = Task.new(name: "task_test", detail: "task_detail",deadline: 1.month.ago, status: :waiting)
    expect(task).not_to be_valid
  end
  it 'nameが50文字以上ならバリデーションが通らない' do
    # ここに内容を記載する
    task = Task.new(name: "a"*51, detail: "task_detail",deadline: 1.month.ago, status: :waiting,priority: :low)
    expect(task).not_to be_valid
  end
  it 'detailが200文字以上ならバリデーションが通らない' do
    # ここに内容を記載する
    task = Task.new(name: "task_test", detail: "t"*201,deadline: 1.month.ago, status: :waiting)
    expect(task).not_to be_valid
  end
  it '全ての項目に内容が記載されておりname 50文字以内,detail 200文字以内の場合,バリデーションが通る' do
    # ここに内容を記載する
    task = Task.new(name: "task_test", detail: "task_detail",deadline: 1.month.ago, status: :waiting, priority: :low)
    expect(task).to be_valid
  end

  context 'scopeメソッドで検索をした場合' do
    before do
      Task.create(name: "scope1", detail: "scope1",deadline: 1.month.ago, status: :waiting, priority: :low)
      Task.create(name: "scope2", detail: "scope2",deadline: 1.month.ago, status: :completed, priority: :low)
    end
    it "scopeメソッドでタイトル検索ができる" do
      expect(Task.name_like('scope1').count).to eq 1
    end
    it "scopeメソッドでステータス検索ができる" do
      expect(Task.completed.count).to eq 1
    end
    it "scopeメソッドでタイトルとステータスの両方が検索できる" do
      expect(Task.name_like('scope2').completed.count).to eq 1
    end
  end
end
