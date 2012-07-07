$(window).load ->
  $("#bookmarke_button")
    .live( "ajax:complete", (xhr) ->
      console.log("complete")
    )
    .live( "ajax:beforeSend", (xhr) ->
      console.log("beforeSend")
    )
    .live( "ajax:success", (event, data, status, xhr) ->
      console.log("success")
    )
    .live( "ajax:error", (data, status, xhr) ->
      console.log("error")
    )

  $("#like_button")
    .live( "ajax:complete", (xhr) ->
      console.log("complete")
      v = $("#like_button").text()
      if v=="like!"
        txt = "liked"
      else
        txt = "like!"

      $("#like_button").text(txt)
    )
    .live( "ajax:beforeSend", (xhr) ->
      console.log("beforeSend")
    )
    .live( "ajax:success", (event, data, status, xhr) ->
      console.log("success")
    )
    .live( "ajax:error", (data, status, xhr) ->
      console.log("error")
    )
