  function fill(block)
  {
    $.ajax({
      url: $('.'+block+'s .dropdown-menu').attr('data-ajax-url'),
      dataType: 'json',
      data: {
        name: $('.'+block+'s .dropdown-menu').find('input').val()
      },
      success: function( json ) {
        $('.'+block+'s .dropdown-menu li:gt(1)').remove();
        $.map( json, function( item ) {
          $('.'+block+'s .dropdown-menu').append("<li><a href='#' class='add_"+block+"' id='" + item.id+ "'>"+item.name+"</a></li>")
        });
      }
    })
  }

function init_autocomplit(block)
{
  $('.'+block+'s .dropdown-menu').find('input').click(function (e) {
    e.stopPropagation();
  });

  $('.'+block+'s .dropdown-menu').find('input').keypress(function (e) {
    fill(block);
  })

  $(document).on('click', '.add_'+block, function (e) {
    e.preventDefault();
    $(e.target).closest('.col-sm-9').find('.search_input').before('<div class="item row"><div class="col-sm-10">' + e.target.innerHTML + '</div><div class="col-sm-2"><a class="remove_'+block+' btn btn-danger btn-xs" id="' + e.target.id + '" href="#">Удалить</a><input type="hidden" name="product['+block+'_ids][]" value="' + e.target.id + '"/></div></div>');
  })

  $(document).on('click', '.remove_'+block, function (e) {
    e.preventDefault();
    e.target.parentNode.parentNode.remove();
  })

  fill(block);
}

$(function (){
  init_autocomplit('linked_product');
});
