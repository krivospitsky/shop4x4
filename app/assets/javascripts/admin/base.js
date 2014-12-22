// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require bootstrap
//= require ckeditor/init
//= require cocoon
//= require_tree .

  function fill(field_name, model_name)
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

function init_autocomplit(field_name, model_name)
{
  $('.'+field_name+'s .dropdown-menu').find('input').click(function (e) {
    e.stopPropagation();
  });

  $('.'+field_name+'s .dropdown-menu').find('input').keypress(function (e) {
    fill(field_name, model_name);
  })

  $(document).on('click', '.add_'+field_name, function (e) {
    e.preventDefault();
    $(e.target).closest('.col-sm-9').find('.search_input').before('<div class="item row"><div class="col-sm-10">' + e.target.innerHTML + '</div><div class="col-sm-2"><a class="remove_'+field_name+' btn btn-danger btn-xs" id="' + e.target.id + '" href="#">Удалить</a><input type="hidden" name="'+model_name+'['+field_name+'_ids][]" value="' + e.target.id + '"/></div></div>');
  })

  $(document).on('click', '.remove_'+field_name, function (e) {
    e.preventDefault();
    e.target.parentNode.parentNode.remove();
  })

  fill(field_name, model_name);
}
