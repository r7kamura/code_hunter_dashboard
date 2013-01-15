class WarningsController < ApplicationController
  def show
    @warning = Warning.find(params[:id])
  end

  def author
    @report = Report.find(params[:report_id])
    @warnings = @report.warnings.where(:author => params[:author])
  end
end
