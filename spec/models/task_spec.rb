# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do
  it 'nameが空ならバリデーションが通らない' do
    task = build(:task, name: '')
    expect(task).not_to be_valid
  end
  it 'detailが空ならバリデーションが通らない' do
    task = build(:task, detail: '')
    expect(task).not_to be_valid
  end
  it 'deadlineが空ならバリデーションが通らない' do
    task = build(:task, deadline: '')
    expect(task).not_to be_valid
  end
  it 'statusが空ならバリデーションが通らない' do
    task = build(:task, status: '')
    expect(task).not_to be_valid
  end
  it 'priorityが空ならバリデーションが通らない' do
    task = build(:task, priority: '')
    expect(task).not_to be_valid
  end
  it 'nameが50文字以上ならバリデーションが通らない' do
    task = build(:task, name: 'a' * 51)
    expect(task).not_to be_valid
  end
  it 'detailが200文字以上ならバリデーションが通らない' do
    task = build(:task, detail: 'a' * 201)
    expect(task).not_to be_valid
  end
  it '全ての項目に内容が記載されておりname 50文字以内,detail 200文字以内の場合,バリデーションが通る' do
    task = build(:task, name: 'a' * 50, detail: 'a' * 200)
    expect(task).to be_valid
  end

  context 'scopeメソッドで検索をした場合' do
    before do
      @task_scope1 = Task.create(name: 'scope1', detail: 'scope1', deadline: 1.month.ago, status: :waiting, priority: :low)
      @task_scope2 = Task.create(name: 'scope2', detail: 'scope2', deadline: 1.month.ago, status: :completed, priority: :low)
    end
    it 'scopeメソッドでタイトル検索ができる' do
      expect(Task.name_like('scope1')).to include(@task_scope1)
      expect(Task.name_like('scope1')).to_not include(@task_scope2)
    end
    it 'scopeメソッドでステータス検索ができる' do
      expect(Task.completed).to include(@task_scope2)
      expect(Task.completed).to_not include(@task_scope1)
    end
    it 'scopeメソッドでタイトルとステータスの両方が検索できる' do
      expect(Task.name_like('scope2').completed).to include(@task_scope2)
      expect(Task.name_like('scope2').completed).to_not include(@task_scope1)
    end
  end
end
