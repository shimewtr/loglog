# frozen_string_literal: true

class Api::FollowRelationshipsController < ApplicationController
  include Rails.application.routes.url_helpers

  protect_from_forgery with: :null_session
  before_action :require_login

  def index
    follow = current_user.active_relationships.where(follower_id: params[:user_id])
    render json: follow
  end

  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    render json: follow
  end

  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:id])
    follow.destroy
  end
end
