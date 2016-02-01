class GradeController < ApplicationController

  def index
    @courses = Course.joins(:instructor).where users: {id: @auth_user}
    if params[:id] != nil
      @histories = History.find_by_sql('SELECT * from histories WHERE course_id = ' + params[:id] + ' and is_current=true')
      @users = User.find_by_sql('SELECT * FROM users WHERE id in (SELECT user_id from histories WHERE course_id =' + params[:id] + ' and is_current=true)')
    end
  end

  def new
    @grades = Grade.new
  end

  def create

    #Update grade
    grade = Grade.new
    grade.gradeletter =  params[:grade]
    grade.history_id = params[:history_id]
    grade.save

    #update history
    history = History.find_by_id params[:history_id]
    history.update_attribute(:is_current, false)

    redirect_to grade_index_path(:id => params[:course_id])
  end

end
