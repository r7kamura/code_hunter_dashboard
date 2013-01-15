class WarningsController < ApplicationController
  def show
    @warning = Warning.find(params[:id])
  end
end
