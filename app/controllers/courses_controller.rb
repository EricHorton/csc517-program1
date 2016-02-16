class CoursesController < ApplicationController

  # Require a student account to access
  before_action :require_student, only: [:my]
  before_action :require_admin, only: [:new]

  # Display all courses for a user
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

  # Add a new course to the system
  def new
    @course = Course.new
  end


  def create
    # Instantiate a new object using form parameters
    attrs = params.permit(:coursenumber, :title, :description, :start_date, :end_date, :created_at, :updated_at, :status, :active, :inactivation_request)
    @instructor = Instructor.find_by_email params[:email]

    attrs[:instructor] = @instructor
    if @instructor
      @course = Course.create(attrs)
      redirect_to courses_path
    else
      @course = Course.new
      render new_course_path
    end
  end
  # def create
  #
  #
  #   # Instantiate a new object using form parameters
  #   @course = Course.new(params.require(:course).permit(:coursenumber, :title, :description, :start_date, :end_date, :created_at, :updated_at, :email, :status, :active, :inactivation_request))
  #
  #   # Save the object
  #   if @course.save
  #     # If save succeeds, redirect to the index action
  #     redirect_to :action => 'index_courses'
  #   else
  #     # If save fails, redisplay the form so user can fix problems
  #     render 'new_course'
  #   end
  # end

  # Display courses belonging to a person
  def my
    # Find all courses for a users
    all = Course.joins(:histories).where histories: {user: @auth_user}

    # Split into current and past courses
    @current = all.where histories: {is_current: true}
    @past = all.where histories: {is_current: false}
  end

  # Display a single course.
  def show
    # Find the course, history, and student enrollment request, if any
    @course = Course.find_by_id params[:id]
    @history = History.find_by(course: @course, user: @auth_user) if @course
    @grade = Grade.find_by(history: @history) if @history
    @request = EnrollmentRequest.find_by(course: @course, student: @auth_user, is_fulfilled: false) unless @history

    # Redirect if course does not exist
    redirect_to root_path unless @course
  end

  def show_instructor
    @course = Course.joins(:users).where user: {user: @auth_user}

  end

  def course_inactive
    @courses = Course.joins(:instructor).where users: {id: @auth_user}

    if(params[:id] != nil && params[:action] == 'course_inactive' && params[:inactivated] != 'true')
      course = Course.find_by_id(params[:id])
      course.inactivation_requested= true
      course.save!

      redirect_to course_inactive_path(:inactivated => true, :id =>params[:id])
    end
  end


end
