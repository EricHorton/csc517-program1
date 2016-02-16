class AdminsController < ApplicationController
  before_action :require_admin

  def index
    @admins = Admin.filter
  end

  # Display a single admin.
  def show
    # Find the details of the admin requested
    @display_admin = Admin.find_by_id params[:id]
  end

  def new
    @admin = Admin.new
  end

  def create
    # Instantiate a new object using form parameters
    attrs = params.require(:admin).permit(:name, :email, :password)
    @admin = Admin.create(attrs) unless params[:admin][:password] != params[:admin][:confirm_password]

    # Save the object
    if @admin
      # If save succeeds, redirect to the index action
      redirect_to admins_path
    else
      # If save fails, redisplay the form so user can fix problems
      @admin = Admin.new
      render new_admin_path
    end
  end

  def delete
    @admin = Admin.find_by_id params[:id]
  end

  def destroy
    admin = Admin.find_by_id params[:id]

    if admin.deletable && admin.id != session[:user_id]
      admin.destroy
    end

    redirect_to admins_path
  end



  # Display a single course.
  def show_course
    # Find the details of the admin requested
    @display_course = Course.find_by_id params[:id]
  end






end
