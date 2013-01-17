window.onload = ->
  last_request_time = new Date()

  append_stream_element = ( el )->
    el='<li class="txtarea txt12">'+el+'</li>'

    list_size = $('#stream_list > li').length
    if list_size==0
      $('#stream_list').append( el );
    else 
      $('#stream_list > li:first').before( el );

    $('#stream_list > li:first').hide();
    $('#stream_list > li:first').slideDown();

  add_element = (req) ->
    s = req.text
    if s.length > 0
      append_stream_element s

  request_newinfo = ->
    param = { t: last_request_time }
    last_request_time = new Date()
    jQuery.getJSON( "/streams/", param, add_element )

  setInterval request_newinfo, 30*1000
