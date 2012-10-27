$(window).load ->
  $("#follow_button")
    .live( "ajax:beforeSend", (xhr) ->
      console.log("beforeSend")
    )
    .live( "ajax:success", (event, data, status, xhr) ->
      console.log("success")
      console.log(data)
      $("#love_area").html("unfollow")
    )
    .live( "ajax:error", (data, status, xhr) ->
      console.log("error")
    )
