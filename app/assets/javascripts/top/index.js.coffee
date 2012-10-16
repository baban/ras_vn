$(window).load ->
  console.log "totemticker"
  $('#stream_list').totemticker({ row_height: '100px', mousestop: true, direction:"up" });
