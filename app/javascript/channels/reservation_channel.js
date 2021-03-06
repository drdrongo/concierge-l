
import consumer from "./consumer"
// consumer.subscriptions.create({ channel: "ReservationChannel" })

const scrollChatToBottom = () => {

  const messages = document.getElementById('messages')
  if (messages) messages.scrollTop = messages.scrollHeight;
};

const createMessage = () => {
  const userId = parseInt(document.cookie.split(/user_id=/).pop(), 10);
  $(function() {
    $('[data-channel-subscribe="reservation"]').each(function(index, element) {
      var $element = $(element),
          reservation_id = $element.data('reservation-id'),
          messageTemplate = $('[data-role="message-template"]');

      scrollChatToBottom();     

      consumer.subscriptions.create(
        {
          channel: "ReservationChannel",
          reservation: reservation_id
        },
        {
          connected() {
            scrollChatToBottom();
          },
          received: function(data) {
            console.log(data);
            var content = messageTemplate.children().clone(true, true);
            content.find('[data-role="message-text"]').text(data.message.content);
            content.find('[data-role="message-date"]').text(data.time_ago);
            content[0].setAttribute("id", "message-" + data.message.id);
            
            if (userId === data.author.id) {
              content[0].classList.add("message-container-self");
            } else {
              content[0].classList.add("message-container-buddy");
            }
            
            content.find('[data-role="message-user"]').text(data.author.first_name)
            $element.append(content);
            scrollChatToBottom();
          }
        }
      );
    });
  });
};



export { createMessage };