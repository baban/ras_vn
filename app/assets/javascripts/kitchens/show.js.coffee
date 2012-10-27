$(window).load ->
  $("#follow_button")
    .live( "ajax:beforeSend", (xhr) ->
      console.log("beforeSend")
    )
    .live( "ajax:success", (event, data, status, xhr) ->
      console.log("success")
      console.log(data)
      if data["value"]
        txt = "unfollow"
      else
        txt = "follow"
      $("#follow_button").text( txt )
    )
    .live( "ajax:error", (data, status, xhr) ->
      console.log("error")
    )
