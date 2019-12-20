# frozen_string_literal: true

require "rails_helper"

describe "Mailer", type: :mailer do
  describe "仮登録時のメールが送信されたとき" do
    before do
      user = FactoryBot.create(:user, email: "loglog@loglog.me")
      @mail = UserMailer.activation_needed_email(user)
    end

    it "タイトルに仮登録完了が含まれる" do
      expect(@mail.subject).to have_content "【LogLog】仮登録完了のお知らせ / 本登録のお願い"
    end

    it "送信者が正しいか" do
      expect(@mail.from).to eq ["info@loglog.me"]
    end

    it "受信者が正しいか" do
      expect(@mail.to).to eq ["loglog@loglog.me"]
    end

    it "ユーザー認証を完了する旨が本文に記載されているか" do
      expect(@mail.body.encoded).to have_content "以下のリンクからユーザー認証を完了してください。"
    end
  end

  describe "アクティベーション完了のメールが送信されたとき" do
    before do
      user = FactoryBot.create(:user, email: "loglog@loglog.me")
      @mail = UserMailer.activation_success_email(user)
    end

    it "タイトルに方登録完了が含まれる" do
      expect(@mail.subject).to have_content "【LogLog】本登録完了のお知らせ"
    end

    it "送信者が正しいか" do
      expect(@mail.from).to eq ["info@loglog.me"]
    end

    it "受信者が正しいか" do
      expect(@mail.to).to eq ["loglog@loglog.me"]
    end

    it "ログインする旨が本文に記載されているか" do
      expect(@mail.body.encoded).to have_content "以下のリンクからログインすることができます。"
    end
  end
end
