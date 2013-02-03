window.onload = ->
  $("#facebook_friends_select_all_friends_area").removeClass("disable")
  $("#select_all_friends").click ->
    check = ($("#select_all_friends").attr("checked")=="checked" ? true : false)
    $("ul.friends input.invite_check").attr("checked", check )
