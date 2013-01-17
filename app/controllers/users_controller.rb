class UsersController < ApplicationController
  before_filter :require_login, :require_latest_report

  def show
    @warnings          = @report.warnings.where(:email => current_user.email)
    @brakeman_warnings = @warnings.select {|warning| warning.service == "brakeman" }
    @rbp_warnings      = @warnings.select {|warning| warning.service == "rails_best_practices" }
  end
end
