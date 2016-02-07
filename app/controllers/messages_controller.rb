class MessagesController < ApplicationController
  before_action :require_student_or_instructor

  def index
    if @auth_user.type == 'Student'
      @messages = Message.where student: @auth_user
    else
      @messages = Message.where instructor: @auth_user
    end
  end
end
