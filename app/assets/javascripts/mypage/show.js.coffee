$(window).load ->
  $(".follow_button")
    .live( "ajax:success", (event, data, status, xhr) ->
      if data["value"]
        txt = "unfollow"
      else
        txt = "follow"
      $("#follow_button").text( txt )
    )
