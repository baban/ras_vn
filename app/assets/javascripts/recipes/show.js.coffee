$(window).load ->
  document.body.oncontextmenu= (e)->
    alert "forbiddon right click!!"
    false

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
    .live( "ajax:beforeSend", (xhr) ->
      console.log("beforeSend")
    )
    .live( "ajax:success", (event, data, status, xhr) ->
      console.log("success")
      console.log(data)
      $("#love_area").html("love("+data["count"]+")")
    )
    .live( "ajax:error", (data, status, xhr) ->
      console.log("error")
    )
