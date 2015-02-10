$(document).ready(function() {
  $("a.fancybox").fancybox();

  $(".attributes tr:gt(4)").hide();

  $(".show-all").click(function(){
        $(this).hide()
        //$(".show_recent_only").show()
        $(".attributes tr:gt(4)").slideDown()
        return false;
    });
  
   $("#lightSlider").lightSlider({autoWidth: false, item: 1}); 

});