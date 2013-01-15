class WarningsController < ApplicationController
  def show
    @warning = Warning.find(params[:id])
  end

  def author
    @warnings = Report.find(params[:report_id]).warnings.where(:author => params[:author])
  end
end
