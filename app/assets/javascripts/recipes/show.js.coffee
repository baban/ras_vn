window.onload = ->
  $("#love_button").removeClass("disable")

  $("#bookmark_button")
    .live( "ajax:complete", (xhr) ->
      v = $("#bookmark_button").text()
      if v=="bookmark"
        txt = "bookmarked"
      else
        txt = "bookmark"
      $("#bookmark_button").text(txt)
    )

  $(".arigato a")
    .live( "ajax:success", (event, data, status, xhr) ->
      console.log "aaaaaa"
      $("#love_area").html("<span class='loved'>love("+data["count"]+")</span>")
    )


  $('#recipe_image_link').colorbox();
