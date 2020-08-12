
import consumer from "./consumer"
 
// consumer.subscriptions.create({ channel: "ReservationChannel" })

$(function() {
  $('[data-channel-subscribe="reservation"]').each(function(index, element) {
    var $element = $(element),
      reservation_id = $element.data('reservation-id')
      messageTemplate = $('[data-role="message-template"]');
    
    $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000)        
    
    console.log("I'm before...")

    consumer.subscriptions.create(
      {
        channel: "ReservationChannel",
        reservation: reservation_id
      },
      {
        received: function(data) {
          var content = messageTemplate.children().clone(true, true);
          content.find('[data-role="message-text"]').text(data.content);
          content.find('[data-role="message-date"]').text(data.updated_at);
          $element.append(content);
          $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000);
        }
      }
    );
    
    console.log("I'm after!")

  });
});