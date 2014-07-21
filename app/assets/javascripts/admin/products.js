  function fill(field_name)
  {
    $.ajax({
      url: $('.'+field_name+'s .dropdown-menu').attr('data-ajax-url'),
      dataType: 'json',
      data: {
        name: $('.'+field_name+'s .dropdown-menu').find('input').val()
      },
      success: function( json ) {
        $('.'+field_name+'s .dropdown-menu li:gt(1)').remove();
        $.map( json, function( item ) {
          $('.'+field_name+'s .dropdown-menu').append("<li><a href='#' class='add_"+field_name+"' id='" + item.id+ "'>"+item.name+"</a></li>")
        });
      }
    })
  }

function init_autocomplit(field_name)
{
  $('.'+field_name+'s .dropdown-menu').find('input').click(function (e) {
    e.stopPropagation();
  });

  $('.'+field_name+'s .dropdown-menu').find('input').keypress(function (e) {
    fill(field_name);
  })

  $(document).on('click', '.add_'+field_name, function (e) {
    e.preventDefault();
    $(e.target).closest('.col-sm-9').find('.search_input').before('<div class="item row"><div class="col-sm-10">' + e.target.innerHTML + '</div><div class="col-sm-2"><a class="remove_'+field_name+' btn btn-danger btn-xs" id="' + e.target.id + '" href="#">Удалить</a><input type="hidden" name="product['+field_name+'_ids][]" value="' + e.target.id + '"/></div></div>');
  })

  $(document).on('click', '.remove_'+field_name, function (e) {
    e.preventDefault();
    e.target.parentNode.parentNode.remove();
  })

  fill(field_name);
}
