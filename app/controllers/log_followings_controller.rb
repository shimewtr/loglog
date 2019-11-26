# frozen_string_literal: true

class LogFollowingsController < ApplicationController
  def create
    log_following = current_user.log_followings.build(log_id: params[:log_id])
    @log = Log.find(params[:log_id])
    log_following.save
    redirect_to @log
  end

  def destroy
    log_following = LogFollowing.find_by(log_id: params[:log_id], user_id: current_user.id)
    log_following.destroy
    @log = Log.find(params[:log_id])
    redirect_to @log
  end
end
