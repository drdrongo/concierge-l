
import consumer from "./consumer"
// consumer.subscriptions.create({ channel: "ReservationChannel" })

const scrollChatToBottom = () => {

  const messages = document.getElementById('messages')
  if (messages) messages.scrollTop = messages.scrollHeight;
};

const createMessage = () => {
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

            content[0].setAttribute("id", data.id);

            content[0].classList.add("align-self-end");
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