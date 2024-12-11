class ChatChannel < ApplicationCable::Channel
  def subscribed # 接続
    # チャットルームに参加
    # stream_from "chat_#{params[:chat_id]}"
    stream_from "chat_1"
    puts params[:chat_id]
    puts '!'*1000
  end

  def unsubscribed # 切断
    # チャットルームから退室（後で処理を追加することもできます）
  end

  def receive(data) # パブリッシャからメッセージを受信
    # クライアントから送られたメッセージを受け取る
    puts params[:chat_id]
    puts '&'*1000
    puts current_user
    message = Message.create!(content: data['message'], user: current_user)

    # メッセージを送信
    ActionCable.server.broadcast("chat_1", {message: render_message(message)})
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(
      partial: 'messages/message',
      locals: { message: message }
    )
  end
end
