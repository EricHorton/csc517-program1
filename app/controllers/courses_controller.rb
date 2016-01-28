class CoursesController < ApplicationController

  # Require a student account to access
  before_action :require_student, only: [:index]

  # Display all courses
  def index
    if params[:like]
      # Wildcard matching
      like = "%#{params[:like]}%"

      # Filter courses
      @courses = Course.joins(:instructor).where('(coursenumber LIKE :like ' +
                                ' OR title LIKE :like' +
                                ' OR users.name LIKE :like' +
                                ' OR description LIKE :like)' +
                                ' AND status = :status',
                                :like => like, :status => params[:status])
    else
      @courses = Course.all
    end
  end

  # Display a single course.
  def show
    # Find the course and student enrollment request, if any
    @course = Course.find_by_id params[:id]
    @request = EnrollmentRequest.find_by(course: @course, student: @auth_user) if @course

    # Redirect if course does not exist
    redirect_to root_path unless @course
  end
end
