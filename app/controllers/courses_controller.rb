class CoursesController < ApplicationController

  # Display all courses
  def index
    @courses = Course.all
  end
end
