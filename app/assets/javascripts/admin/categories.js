$(window).load(function(){
  $( ".sortable-cat" ).sortable({
    update : function (event, ui) { 
    	id=ui.item.attr('id')
    	if (id) {
	    	$.ajax({
			  type: 'PATCH',
			  url: '/admin/categories/'+id,
			  dataType: 'json',
			  data: { category: { sort_order_position: ui.item.index() } },  // or whatever your new position is
			});
		}
    }
  });
  $( ".sortable-cat" ).disableSelection();
});
