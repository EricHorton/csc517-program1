class UsersController < ApplicationController

  before_action :require_student_or_admin, only: [:edit]

  # Get a page for editing a users
  def edit
    begin
      student_check
      @user = User.find params[:id]
    rescue
      redirect_to root_path
    end
  end

  # Update user
  def update
    begin

      student_check
      attrs = params.require(:user).permit :name, :email

      User.find(params[:id]).update_attributes attrs

      redirect_to root_path
    rescue
      redirect_to edit_user_path(params[:id])
    end
  end

  # Check that if the user is a student they are requesting their information
  def student_check
   if @auth_user.type == 'Student' && @auth_user.id != Integer(params[:id])
      raise 'A student cannot edit another user'
    end
  end
end
