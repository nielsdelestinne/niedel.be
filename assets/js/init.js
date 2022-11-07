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

      html2canvas(document.body).then((canvas) => {
        const containerElement = document.createElement("a");
        containerElement.download = `niels_delestinne_cv_${Date.now()}.png`;
        containerElement.href = canvas.toDataURL("application/pdf");
        containerElement.click();
        $('.download-cv').show();
        $('.downloading-cv').hide();
      });
    });

  }); // end of document ready
})(jQuery); // end of jQuery name space