// app/javascript/channels/chat.js
import consumer from "../consumer";

// チャットチャネルの作成
const chatChannel = consumer.subscriptions.create(
  { channel: "ChatChannel", chat_id: 1 }, // チャットIDを設定
  {
    received(data) {
      // 受信したメッセージを画面に表示する処理
      const messagesElement = document.getElementById('messages');
      const message = `<p>${data.message}</p>`;
      messagesElement.innerHTML += message; // メッセージを追加
    },

    // メッセージ送信処理
    speak(message) {
      if (message.trim().length > 0) {
        this.perform('receive', { message: message }); // メッセージを送信
      }
    }
  }
);

// メッセージ送信の処理
document.addEventListener("DOMContentLoaded", () => {
  const messageInput = document.getElementById("message_input");
  const sendButton = document.getElementById("send_button");

  // 送信ボタンがクリックされた時
  sendButton.addEventListener("click", function(e) {
    e.preventDefault();
    const message = messageInput.value.trim();
    chatChannel.speak(message); // メッセージを送信
    messageInput.value = ""; // 入力フィールドをクリア
  });

  // Ctrl + Enterで送信
  messageInput.addEventListener("keydown", function(e) {
    if (e.ctrlKey && e.key === "Enter") {
      e.preventDefault();
      const message = messageInput.value.trim();
      chatChannel.speak(message); // メッセージを送信
      messageInput.value = ""; // 入力フィールドをクリア
    }
  });
});
