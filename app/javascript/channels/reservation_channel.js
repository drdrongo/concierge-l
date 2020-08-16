
import consumer from "./consumer"
// consumer.subscriptions.create({ channel: "ReservationChannel" })
const createMessage = () => {
  $(function() {
    $('[data-channel-subscribe="reservation"]').each(function(index, element) {
      const currentUserId = parseInt(document.cookie.split(/user_id=/)[1], 10);
      var $element = $(element),
          reservation_id = $element.data('reservation-id'),
          messageTemplate = $('[data-role="message-template"]');

      $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000)        

      consumer.subscriptions.create(
        {
          channel: "ReservationChannel",
          reservation: reservation_id
        },
        {
          received: function(data) {
            let date = new Date(data.updated_at)
            , options = {weekday: 'short', month: 'short', day: 'numeric', timestyle: 'short', hour12: true, hour: '2-digit', minute: '2-digit' };
            var content = messageTemplate.children().clone(true, true);
            content.find('[data-role="message-text"]').text(data.content);
            content.find('[data-role="message-date"]').text(date.toLocaleString('en-GB', options));

            content[0].setAttribute("id", data.id);
            if (currentUserId === data.user_id) {
              content[0].classList.add("align-self-end");
            }
            $element.append(content);
            $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000);
          }
        }
      );
    });
  });
};



export { createMessage };