class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = Message.includes(:user).order(created_at: :asc)
    @message = Message.new
  end

  def create
    @message = current_user.messages.new(message_params)

    if @message.save
      ActionCable.server.broadcast "chat_#{params[:chat_id]}", message: render_message(@message)
      redirect_to messages_path
    else
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
