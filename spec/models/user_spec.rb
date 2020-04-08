require "rails_helper"
RSpec.describe "User管理機能", type: :model do

  it "nameが空ならバリデーションが通らない" do
    user = build(:user,name:"")
    expect(user).not_to be_valid
  end

  it "emailが空ならバリデーションが通らない" do
    user = build(:user,email:"")
    expect(user).not_to be_valid
  end

  it "passwordが空ならバリデーションが通らない" do
    user = build(:user,password: "")
    expect(user).not_to be_valid
  end

  it "nameが30文字以上ならバリデーションが通らない" do
    user = build(:user,name: "a"*31)
    expect(user).not_to be_valid
  end

  it "emailが255文字以上ならバリデーションが通らない" do
    user = build(:user,email:"a"*247+"@test.com")
    expect(user).not_to be_valid
  end

  it "emailが255文字以内でemailフォーマットでない場合,バリデーションが通らない" do
    user = build(:user,email:"a"*25+"test.com")
    expect(user).not_to be_valid
  end

  it "同じemailの場合,バリデーションが通らない" do
    user1 = create(:user,email:"b"*50+"@test.com")
    user2 = build(:user,email:"b"*50+"@test.com")
    expect(user2).not_to be_valid
  end

  it "passwordが6文字未満ならバリデーションが通らない" do
    user = build(:user,password:"a"*5)
    expect(user).not_to be_valid
  end

  it "全ての項目に内容が記載されておりname 30文字以内,email 255文字以内かつemailフォーマットを満たし,password 6文字以上の場合,バリデーションが通る" do
    user = build(:user,name:"a"*30,email:"a"*200+"@test.com",password: "123456")
    expect(user).to be_valid
  end


end
