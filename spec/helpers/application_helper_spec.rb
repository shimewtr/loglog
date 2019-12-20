# frozen_string_literal: true

require "rails_helper"
describe "ApplicationHelper" do
  describe "page_title" do
    context "ページタイトルが設定されていないとき" do
      it "LogLog を返す" do
        expect(helper.page_title).to eq "LogLog"
      end
    end

    context "ページタイトルが設定されているとき" do
      before do
        @page_title = "タイトルのテスト"
      end

      it "ページタイトル | LogLog を返す" do
        expect(helper.page_title).to eq "タイトルのテスト | LogLog"
      end
    end
  end
end
