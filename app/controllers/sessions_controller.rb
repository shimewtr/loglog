# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create], raise: false

  def new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to(root_path)
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to welcome_path
  end
end
