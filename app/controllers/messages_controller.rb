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

  # TODO restrict to active participants
  # Display a single message
  def show
    if (@message = Message.find_by_id params[:id])
      @posts = Post.where(message: @message).order :created_at
    else
      redirect_to messages_path
    end
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
