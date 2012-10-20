$(window).load ->
  append_stream_element = ( el )->
    el='<li class="txtarea txt12">'+el+'</li>'

    list_size = $('#stream_list > li').length
    if list_size==0
      $('#stream_list').append( el );
    else 
      $('#stream_list > li:first').before( el );

    $('#stream_list > li:first').hide();
    $('#stream_list > li:first').slideDown();

  request_newinfo = ->
    param = { t: new Date() }
    jQuery.getJSON( "/information/newinfo", param, append_stream_element )
    
  add_element = (data)->
    s="aaaaaaaaaaaaaaaaaaaa"
    append_stream_element s

  setInterval add_element, 3000
