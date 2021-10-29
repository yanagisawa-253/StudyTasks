# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Userモデル', type: :model do
  describe 'バリデーションのテスト' do

    subject { user.valid? }

    let(:user) { build(:user) }

    context 'nameカラム' do
      it "有効なuser登録の場合は保存されるか" do
        expect(FactoryBot.create(:user)).to be_valid
      end
      it "名前がなければ登録できない" do
        expect(FactoryBot.build(:user, name: "")).to_not be_valid
      end
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
      user.name = Faker::Lorem.characters(number: 1)
      is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      it "メールアドレスがなければ登録できない" do
        expect(FactoryBot.build(:user, email: "")).to_not be_valid
      end
      it "パスワードがなければ登録できない" do
        expect(FactoryBot.build(:user, password: "")).to_not be_valid
      end
      it "空でないこと" do
        user.email = ''
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '50文字以下であること: 51文字は×' do
        user.introduction = Faker::Lorem.characters(number: 251)
        is_expected.to eq false
      end
    end

    context 'passwordカラム' do
      it "空でないこと" do
        user.password = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Taskモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:tasks).macro).to eq :has_many
      end
    end
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'Likeモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:likes).macro).to eq :has_many
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end
  end
end

