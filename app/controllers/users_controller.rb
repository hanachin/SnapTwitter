class UsersController < ApplicationController
  respond_to :html

  # GET /
  # GET /
  def me
    @user = current_user
    respond_with(@user)
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to root_path, notice: 'User was successfully updated.'
    else
      redirect_to root_path, notice: 'Something wrong.'
    end
  end
end
