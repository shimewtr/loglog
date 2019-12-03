# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :require_login, only: [:index], raise: false

  def index
    @logs = Log.order(updated_at: :desc).limit(10)
  end
end
