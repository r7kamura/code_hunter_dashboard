class ReportsController < ApplicationController
  protect_from_forgery

  before_filter :require_warnings_as_json, only: :create

  def create
    Report.create_with_warnings(@warnings)
    head :ok
  end

  private

  def require_warnings_as_json
    @warnings = JSON.parse(params[:warnings])
  rescue JSON::ParserError, TypeError
    head :bad_request
  end
end