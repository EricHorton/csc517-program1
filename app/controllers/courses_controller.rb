class CoursesController < ApplicationController

  # Require a student account to access
  before_action :require_student, only: [:index]

  # Display all courses
  def index
    if params[:like]
      # Wildcard matching
      like = "%#{params[:like]}%"

      # Filter courses
      @courses = Course.joins(:instructor).where('coursenumber LIKE :like ' +
                                ' OR title LIKE :like' +
                                ' OR users.name LIKE :like' +
                                ' OR description LIKE :like',
                                :like => like)
    else
      @courses = Course.all
    end
  end
end
