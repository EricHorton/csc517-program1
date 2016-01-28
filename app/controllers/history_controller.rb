class HistoryController < ApplicationController
  def destroy
    history = History.find_by_id params[:id]
    if history
      history.is_current = false
      history.save
      redirect_to course_path(history.course)
    else
      redirect_to root_path
    end
  end
end
