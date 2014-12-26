$(window).load(function(){
  $( "#pages_list.sortable" ).sortable({
    update : function (event, ui) { 
    	id=ui.item.attr('id')
    	if (id) {
	    	$.ajax({
			  type: 'PUT',
			  url: '/admin/pages/'+id,
			  dataType: 'json',
			  data: { page: { sort_order_position: ui.item.index() } },  // or whatever your new position is
			});
		}
    }
  });
  $( "#sortable" ).disableSelection();
});
