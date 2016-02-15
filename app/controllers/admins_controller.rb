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

  def index_users
    @users = User.where.not type: 'Admin'
  end

  # Display a single user.
  def show_users
    # Find the details of the user requested
    @display_user = User.find_by_id params[:id]
  end

  def delete_user
    @user = User.find_by_id params[:id]
  end

  def destroy_user
    user = User.find_by_id params[:id]
    user.destroy
    redirect_to(:action => 'index_users')
  end

  def index_courses
    @courses = Course.all
  end

  # Display a single course.
  def show_course
    # Find the details of the admin requested
    @display_course = Course.find_by_id params[:id]
  end

  # Add a new course to the system
  def new_course
    @course = Course.new
  end

  def create_course
    # Instantiate a new object using form parameters
    @course = Course.new(params.require(:course).permit(:coursenumber, :title, :description, :start_date, :end_date, :created_at, :updated_at, :instructor_id, :status, :active, :inactivation_request))

    # Save the object
    if @course.save
      # If save succeeds, redirect to the index action
      redirect_to :action => 'index_courses'
    else
      # If save fails, redisplay the form so user can fix problems
      render 'new_course'
    end
  end


end
