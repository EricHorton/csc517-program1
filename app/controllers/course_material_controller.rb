class CourseMaterialController < ApplicationController


  def index
    if @auth_user.type == 'Instructor'
      @courses = Course.joins(:instructor).where users: {id: @auth_user}
    end
  end

  def new
    @course_material = CourseMaterial.new
  end

  def create
    i = 0
    tasks = Task.new
    tasks.title = params[:title]
    tasks.description = params[:description]
    tasks.deadline = Time.strptime(params[:deadline], "%m/%d/%Y %H:%M %p")
    tasks.save!

    @course_material = CourseMaterial.new
    @course_material.task_id = tasks.id
    @course_material.course_id = session[:courseid]
    @course_material.save!

    redirect_to course_material_index_path(:id => session[:courseid])

  end
end
