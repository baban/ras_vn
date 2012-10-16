$(window).load ->
  console.log "totemticker"
  $('#stream_list').totemticker({ row_height: '70px', mousestop: true, max_items: 4, direction:"down" });
