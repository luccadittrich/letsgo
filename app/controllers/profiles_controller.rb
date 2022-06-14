class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @follows = Follow.find_by(user_id: current_user.id, followed_id: params[:id])
  end
end
