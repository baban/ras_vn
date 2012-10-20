$(window).load ->
  console.log "totemticker"
  $('#stream_list').totemticker({ row_height: '70px', mousestop: true, direction: "down" });
