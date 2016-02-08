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
    @message = Message.new
  end

  # Create a new message
  def create
    # Get the other user
    other_user = User.find_by_id params[:user_id]

    # Determine instructor and student
    instructor = @auth_user.type == 'Instructor' ? @auth_user : other_user
    student = instructor == other_user ? @auth_user : other_user

    # Create the message
    message = Message.create do |m|
      m.subject = params[:subject]
      m.instructor = instructor
      m.student = student
    end

    # Create the post
    Post.create do |p|
      p.message = message
      p.user = @auth_user
      p.content = params[:content]
    end

    # Redirect to message
    redirect_to message_path(message)
  end
end
