# frozen_string_literal: true

class Api::LogFollowingsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :require_login

  def index
    log_follow = current_user.log_followings.find_by(log_id: params[:log_id])
    render json: log_follow
  end

  def create
    log_follow = current_user.log_followings.build(log_id: params[:log_id])
    log_follow.save

    render json: log_follow
  end

  def destroy
    log_follow = current_user.log_followings.find_by(log_id: params[:id])
    log_follow.destroy
  end
end
