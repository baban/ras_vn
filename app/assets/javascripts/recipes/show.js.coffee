$(window).load ->
  $("#bookmark_button")
    .live( "ajax:complete", (xhr) ->
      v = $("#bookmark_button").text()
      if v=="bookmark"
        txt = "bookmarked"
      else
        txt = "bookmark"
      $("#bookmark_button").text(txt)
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

  $("#love_button")
    .live( "ajax:complete", (xhr) ->
      $("#love_area").html("love")
    )
