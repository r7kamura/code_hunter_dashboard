class ReportsController < ApplicationController
  protect_from_forgery

  before_filter :require_warnings_as_json, only: :create
  before_filter :require_latest_report, :only => [:top, :dashboard, :latest]

  def index
    @reports = Report.descending.limit(20)
  end

  def show
    @report = Report.find(params[:id])
  end

  def top
  end

  def dashboard
    @reports = Report.descending.limit(100)
  end

  def latest
    @report = Report.latest
    render :show
  end

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
