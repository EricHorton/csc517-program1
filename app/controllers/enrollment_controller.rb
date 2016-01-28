class EnrollmentController < ApplicationController

  before_action :require_student, only: [:create]

  # Create a new enrollment request
  def create
    # Get course and student
    course = Course.find_by_id params[:course_id]
    student = Student.find_by_id params[:student_id]

    # Either find or create a new request
    @request = EnrollmentRequest.find_or_create_by course: course, student: student

    # Redirect to course page
    redirect_to course_path(course)
  end
end
