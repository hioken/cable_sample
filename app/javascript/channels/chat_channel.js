import consumer from "./consumer";

const chatChannel = consumer.subscriptions.create(
  { channel: "ChatChannel", chat_id: 1 },
  {
    received(data) {
      const messagesElement = document.getElementById('messages');
      messagesElement.innerHTML += data.message;

      messagesElement.scrollTop = messagesElement.scrollHeight;
    },
    speak(messageInput) {
      const message = messageInput.value.trim();
      if (message.trim().length > 0) {
        this.perform('receive', { message: message });
        messageInput.value = "";
      }
    }
  }
);

document.addEventListener("DOMContentLoaded", () => {
  const messageInput = document.getElementById("message_input");
  const sendButton = document.getElementById("send_button");

  // 送信ボタンがクリックされた時
  sendButton.addEventListener("click", function(e) {
    e.preventDefault();
    chatChannel.speak(messageInput);
  });

  // Ctrl + Enterで送信
  messageInput.addEventListener("keydown", function(e) {
    if (e.ctrlKey && e.key === "Enter") {
      e.preventDefault();
      chatChannel.speak(messageInput);
    }
  });
});
