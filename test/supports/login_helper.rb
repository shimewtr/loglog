# frozen_string_literal: true

module LoginHelper
  def login_user(login_name, password)
    visit welcome_path
    fill_in("email", with: login_name)
    fill_in("password", with: password)
    click_button "ログイン"
  end

  def logout
    click_link "ログアウト"
  end
end
