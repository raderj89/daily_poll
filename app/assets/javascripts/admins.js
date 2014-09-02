$(function() {
  $('.poll-list').sortable({
    axis: 'y',
    containment: "parent",
    forceHelperSize: true,
    forcePlaceholderSize: true,
    update: function() {
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
        .done(function(resp) {
          $('.poll-list li').each(function(i) {
            console.log(resp.dates);
            $(this).find('span.date').html($.datepicker.formatDate('m.dd', new Date(resp.dates[i] + "EDT")));
          });
        });
    }
  });
})
