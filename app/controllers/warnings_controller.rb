class WarningsController < ApplicationController
  protect_from_forgery

  before_filter :require_warnings, only: :create

  def create
    Warning.mass_create(warnings)
    head :ok
  end

  private

  def require_warnings
    @warnings = JSON.parse(params[:warnings])
  rescue JSON::ParserError, TypeError
    head :bad_request
  end
end
