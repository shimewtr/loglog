# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login

  protected

    def not_authenticated
      redirect_to welcome_path
    end
end
