class UsersController < ApplicationController

  before_action :require_student_or_admin, only: [:edit]
  before_action :require_admin, only: [:index, :show, :delete, :destroy]

  # Check that if the user is a student they are requesting their information
  def student_check
    if @auth_user.type == 'Student' && @auth_user.id != Integer(params[:id])
      raise 'A student cannot edit another user'
    end
  end

  # Show all non Admin users.
  def index
    @users = User.where.not type: 'Admin'
  end

  # Display a single user.
  def show
    # Find the details of the user requested
    @display_user = User.find_by_id params[:id]
      # Find all courses for a users
    if @display_user.type == 'Student'
        all = Course.joins(:histories).where histories: {user: @display_user}

        # Split into current and past courses
        @current = all.where histories: {is_current: true}
        @past = all.where histories: {is_current: false}
    else
      @current = Course.where instructor: @display_user

    end
  end

  # Deletion confirmation page
  def delete
    @user = User.find_by_id params[:id]
  end

  # Delete a user
  def destroy
    user = User.find_by_id params[:id]
    user.destroy if user.deletable
    redirect_to(:action => 'index')
  end

  # Get a page for editing a user
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

  # Template for updating passwords
  def edit_password
    begin
      student_check
    rescue
      redirect_to root_path
    end
  end

  # Update a user password
  def update_password
    begin
      student_check

      # Password and confirmation
      password = params[:password][:password]
      conf = params[:password][:confirm_password]

      # If password and conf match and are not empty
      if !password.empty? && password == conf
        # Update and redirect
        User.find(params[:id]).update_attribute :password, password
        redirect_to edit_user_path
      else
        redirect_to password_user_path
      end
    rescue
      redirect_to root_path
    end
  end

end
