window.onload = ->
  $(".follow_button").removeClass("disable")
  $(".follow_button")
    .live( "ajax:success", (event, data, status, xhr) ->
      if data["value"]
        $(this).removeClass("unfollow").addClass("follow")
        $(this).html( "<span>kết nối</span>" )
      else
        $(this).removeClass("follow").addClass("unfollow")
        $(this).html( "<span>Đang kết nối</span>" )
    )
