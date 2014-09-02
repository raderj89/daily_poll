function isScrolledIntoView(elem) {
  var docViewTop = $(window).scrollTop();
  var docViewBottom = docViewTop + $(window).height();

  var elemTop = $(elem).offset().top;
  var elemBottom = elemTop + $(elem).height();

  return ((elemBottom <= docViewBottom));
}

function hideIfZero(elem) {
  if ($(elem).find('span').text() == "0%") {
    $(elem).remove();
  }
}

$( document ).ready( function() {
  $(".new_user").submit( function(e) {
    e.preventDefault();
    var $this = $(this);
    var name = $this.find("#user_name").val();
    var phone = $this.find("#user_phone").val();

    $.post('/users', { user: {name: name, phone: phone } } )
      .done(function(res) {
        console.log(res);
        if(res.status == 'success') {
          $("div.new-user-form")
            .append("<div id='subscribed'><div class='arrow-left'></div><span>Woo hoo! You're subscribed!</span></div>")
            .toggleClass('subscribed');
          $('.footer .new-user-form h1').text("You are 1 of "+ res.user_count + " others on Daily Poll")
        } else {
          $("div.new-user-form").append("<span> Something went wrong </span>");
        }
      })
  })

  // latest question

  $(window).scroll(function() {
    console.log($(window).scrollTop() + $(window).height());
    if (isScrolledIntoView($('.question-header'))) {
      console.log("yep");
      $('.yes-box').slideDown(1000);
      $('.no-box').slideDown(1000);  
    } else {
      $('.yes-box').slideUp(10);
      $('.no-box').slideUp(10);  
    }
  });


  hideIfZero('.no-box');
  hideIfZero('.yes-box');

  // archive update partial 
  $(".archive-index ul li").on("click", function(e){
    var $this = $(this);
    var question = $this.find("span.question").data('question-text');
    // var date = $this.find("span.date").text();
    $.post('/pages/show_poll', {question: question})
      .done(function(response) {
        $(".poll").hide().html(response).fadeIn(1500);
      })
  })

  // archive arrow scroll
  $('.archive-poll').on( "click", '.poll-scroll .previous-poll', function() {
    var question = $('.previous-poll-data').data("previous-poll");
    $.post('/pages/show_poll', {question: question})
      .done(function(response) {
        $(".poll").hide().html(response).fadeIn(1500);
      })
  })

  $('.archive-poll').on( "click", '.poll-scroll .next-poll', function() {
    var question = $(".next-poll-data").data("next-poll");
    $.post('/pages/show_poll', {question: question})
      .done(function(response) {
        $(".poll").hide().html(response).fadeIn(1500);
      })
  })
}) // end document ready 