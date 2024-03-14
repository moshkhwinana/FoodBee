class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]

  def home
    @user = current_user
  end
end
