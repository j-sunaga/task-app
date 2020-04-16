require 'rails_helper'

RSpec.describe Label, type: :model do

  it "nameが空ならバリデーションが通らない" do
    label = build(:label,name:"")
    expect(label).not_to be_valid
  end

  it "nameが50以上ならバリデーションが通らない" do
    label = build(:label,name:"a"*51)
    expect(label).not_to be_valid
  end

  it "nameが50以下ならバリデーションが通る" do
    label = build(:label,name:"a"*50)
    expect(label).to be_valid
  end

end
