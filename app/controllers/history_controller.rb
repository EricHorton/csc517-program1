class HistoryController < ApplicationController


  def index
    if @auth_user.type == 'Instructor'
      @courses = Course.joins(:instructor).where users: {id: @auth_user}
    end

    if(session[:courseid] != nil && params[:id] == nil)
      params[:id] = session[:courseid]
    end

    if params[:id] != nil
      @users = User.joins(:histories).where histories: {course_id: params[:id], is_current: true}
    end

  end

  def create

  end


  def show
    @sd = 1
  end

  def destroy
    history = History.find_by_id params[:id]
    if history
      history.is_current = false
      history.save
      if(params[:courseid] == nil)
        redirect_to course_path(history.course)
      else
        session[:courseid] = params[:courseid]
        redirect_to history_path
      end
    else
      redirect_to root_path
    end
  end
end
