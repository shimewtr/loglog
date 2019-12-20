# frozen_string_literal: true

require "rails_helper"
describe "UsersHelper" do
  describe "user_submit_label" do
    context "editページのラベルは" do
      it "作成になる" do
        expect(helper.user_submit_label(:new)).to eq "作成"
      end
    end

    context "updateページのラベルは" do
      it "更新になる" do
        expect(helper.user_submit_label(:edit)).to eq "更新"
      end
    end
  end
end
