class ProfilesController < ApplicationController 

  def edit
    @user = current_user
    @profile = current_user.prepare_profile
  end

  def update
    @profile = current_user.prepare_profile
    @profile.id = current_user.id
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to root_path, notice: 'アバターを更新できました'
    else
      flash.now[:error] = 'アバターを更新できませんでした'
      render :edit
    end

  end

  private
  def profile_params
    params.require(:profile).permit(:avatar)
  end
end