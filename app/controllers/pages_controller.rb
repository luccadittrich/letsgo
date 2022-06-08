class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @sidebar = 'home'
  end
end
