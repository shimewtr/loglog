# frozen_string_literal: true

module LoginHelper
  def login_user(user, password = "secret")
    visit welcome_path
    fill_in("email", with: user.email)
    fill_in("password", with: password)
    click_button "ログイン"
  end

  def logout
    click_link "ログアウト"
  end
end
