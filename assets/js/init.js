(function($){

  $('.downloading-cv').hide();

  $(function(){

    $('.scrollspy').scrollSpy({
      scrollOffset: 0
    });
    $('.sidenav').sidenav();

    $('.download-cv').on("click", () => {

      $('.downloading-cv').show();
      $('.download-cv').hide();

      setTimeout(() => {
        $('.downloading-cv').hide();
        $('.download-cv').show();
      }, 1500);

    });

  }); // end of document ready
})(jQuery); // end of jQuery name space