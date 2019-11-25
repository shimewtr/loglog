# frozen_string_literal: true

class ValuesController < ApplicationController
  before_action :set_value, only: [:destroy]
  before_action :set_log, only: [:create, :destroy]

  def new
    @value = Value.new
  end

  def create
    @value = @log.values.build(value_params)
    if @value.save
      redirect_to log_path(@log)
    else
      redirect_to log_path(@log)
    end
  end

  def destroy
    @value.destroy
    redirect_to log_path(@log)
  end

  private
    def value_params
      params.permit(:value)
    end

    def set_value
      @value = Value.find(params[:id])
    end

    def set_log
      @log = Log.find(params[:log_id])
    end
end
