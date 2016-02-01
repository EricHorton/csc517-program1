class EnrollmentController < ApplicationController

  before_action :require_student, only: [:create]

  def index
    if @auth_user.type == 'Instructor'
      @courses = Course.joins(:instructor).where users: {id: @auth_user}
    end

    if params[:id] != nil
      @enrollment = EnrollmentRequest.find_by_sql('SELECT * FROM enrollment_requests WHERE course_id =' + params[:id] + ' and is_fulfilled = false' )
      @users = User.find_by_sql('SELECT * FROM users WHERE id in (SELECT student_id from enrollment_requests WHERE course_id =' + params[:id] + ' and is_fulfilled=false)')
    end

  end

  # Create a new enrollment request
  def create
    # Get course and student
    course = Course.find_by_id params[:course_id]
    student = Student.find_by_id params[:id]

    # Either find or create a new request
    @request = EnrollmentRequest.find_or_create_by course: course, student: student

    # Redirect to course page
    redirect_to course_path(course)
  end

  def update
    enrollmentrec = EnrollmentRequest.find_by_id params[:id]
    status = params[:status]
    courseid = params[:courseid]

    if status == 'true'
      enrollmentrec.update_attribute(:is_fulfilled, true)
      history = History.new
      history.is_current= true;
      history.user = enrollmentrec.student
      history.course = enrollmentrec.course
      history.save
      redirect_to enrollment_path(:id => courseid)
    elsif status == 'false'
      enrollmentrec.update_attribute(:is_fulfilled, nil)
      redirect_to enrollment_path(:id => courseid)
    end

  end
end
