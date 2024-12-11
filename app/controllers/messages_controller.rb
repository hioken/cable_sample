class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = Message.includes(:user).order(created_at: :asc)
    @message = Message.new
  end

  def create
    @message = current_user.messages.new(message_params)

    if @message.save
      ActionCable.server.broadcast "chat_1", { message: render_message(@message) }
          puts params[:chat_id]
          puts '?'*1000
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
