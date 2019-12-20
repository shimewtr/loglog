# frozen_string_literal: true

require "rails_helper"
describe "LogHelper" do
  let(:user_a) { FactoryBot.create(:user, name: "usera", email: "user.1@hogehoge.com") }
  let(:user_b) { FactoryBot.create(:user, name: "userb", email: "user.2@hogehoge.com") }
  let(:user_c) { FactoryBot.create(:user, name: "userc", email: "user.3@hogehoge.com") }
  let(:log_a) { FactoryBot.create(:log, title: "ログA", description: "ログAの説明文です。", user: user_a) }

  describe "chart_color" do
    context "赤のグラフのとき" do
      before do
        @log = FactoryBot.create(:log, color: "red")
      end

      it "赤のカラーコードを返す" do
        expect(helper.chart_color(@log)).to eq "#F44336"
      end
    end

    context "青のグラフのとき" do
      before do
        @log = FactoryBot.create(:log, color: "blue")
      end

      it "青のカラーコードを返す" do
        expect(helper.chart_color(@log)).to eq "#3F51B5"
      end
    end

    context "緑のグラフのとき" do
      before do
        @log = FactoryBot.create(:log, color: "green")
      end

      it "緑のカラーコードを返す" do
        expect(helper.chart_color(@log)).to eq "#4CAF50"
      end
    end

    context "オレンジのグラフのとき" do
      before do
        @log = FactoryBot.create(:log, color: "orange")
      end

      it "オレンジのカラーコードを返す" do
        expect(helper.chart_color(@log)).to eq "#FF9800"
      end
    end

    context "紫のグラフのとき" do
      before do
        @log = FactoryBot.create(:log, color: "purple")
      end

      it "紫のカラーコードを返す" do
        expect(helper.chart_color(@log)).to eq "#673AB7"
      end
    end

    context "ピンクのグラフのとき" do
      before do
        @log = FactoryBot.create(:log, color: "pink")
      end

      it "ピンクのカラーコードを返す" do
        expect(helper.chart_color(@log)).to eq "#E91E63"
      end
    end

    context "茶色のグラフのとき" do
      before do
        @log = FactoryBot.create(:log, color: "brown")
      end

      it "茶色のカラーコードを返す" do
        expect(helper.chart_color(@log)).to eq "#795548"
      end
    end
  end

  describe "log_submit_label" do
    context "editページのラベルは" do
      it "作成になる" do
        expect(helper.log_submit_label(:new)).to eq "作成"
      end
    end

    context "updateページのラベルは" do
      it "更新になる" do
        expect(helper.log_submit_label(:edit)).to eq "更新"
      end
    end
  end
end
