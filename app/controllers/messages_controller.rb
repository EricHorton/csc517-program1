class MessagesController < ApplicationController
  before_action :require_student_or_instructor

  # Display all messages for a user.
  def index
    if @auth_user.type == 'Student'
      @messages = Message.where student: @auth_user
    else
      @messages = Message.where instructor: @auth_user
    end
  end

  # Display a single message
  def show
    # TODO
  end

  # Begin creation of a new message
  def new
    # TODO
  end

  # Create a new message
  def create
    # TODO
  end
end
