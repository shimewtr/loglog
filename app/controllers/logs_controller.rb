# frozen_string_literal: true

class LogsController < ApplicationController
  before_action :set_log, only: [:show, :edit, :update, :destroy]
  def index
    @logs = Log.all
  end

  def show
  end

  def new
    @log = Log.new
  end

  def create
    @log = Log.new(log_prams)
    if @log.save
      redirect_to logs_path, notice: "#{@log.title}を作成しました"
    else
      render :new
    end
  end

  def update
    if @log.update(log_prams)
      redirect_to log_path(id: @log.id), notice: "#{@log.title}を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @log.destroy
    redirect_to logs_path, notice: "#{@log.title}を削除しました"
  end

  private
    def set_log
      @log = Log.find_by!(id: params[:id])
    end

    def log_prams
      params.require(:log).permit(:title, :description)
    end
end
