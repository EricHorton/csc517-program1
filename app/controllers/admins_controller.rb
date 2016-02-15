class AdminsController < ApplicationController
  before_action :require_auth

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
    @admin = Admin.new(params.require(:admin).permit(:name, :email, :password))

    # Save the object
    if @admin.save
      # If save succeeds, redirect to the index action
      redirect_to :action => 'index'
    else
      # If save fails, redisplay the form so user can fix problems
      render 'new'
    end
  end

  def delete
    @admin = Admin.find_by_id params[:id]
  end

  def destroy
    admin = Admin.find_by_id params[:id]
    admin.destroy
    redirect_to(:action => 'index')
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
