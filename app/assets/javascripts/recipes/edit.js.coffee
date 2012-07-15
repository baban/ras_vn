send_youtube_url_button = ( i, url )->
  console.log "url"
  console.log url

$(window).load ->
  food_stuff_row = (i)->
    s = 
    '<tr>'+
      '<td class="name"><input type="text" name="foodstuffs[][name]" value=""></td>'+
      '<td class="amount"><input type="text" name="foodstuffs[][amount]" value=""></td>'+
    '</tr>';
    return s;

  $("#add_foodstuffs_row").click ->
    $("#foodstuffs").append(food_stuff_row(4))

  $("#add_steps").click ->
    console.log("hoge");
    s = 
    '<dl class="step">'+
      '<dt>New Step</dt>'+
      '<dd><textarea class="step_edit_area" name="steps[]"></textarea></dd>'+
    '</dl>';
    $("#recipe_steps").append(s)
    
  $("#recipe_genre_selecter").change ->
    $("select#recipe_genre_selecter option:selected").each -> 
      $("#recipe_recipe_food_genre_id").css( "display", "inline" )
      labelname = $(this).text()
      $("#recipe_recipe_food_id optgroup").css( "display", "none" )
      $("#recipe_recipe_food_id optgroup[label='"+labelname+"']").css( "display", "block" )
  
  $("#search_youtube_button").live( "click", ->
    console.log("clock")
    vq = $("#search_youtube_text").attr("value")
    step_number = $("#search_youtube_step_number").attr("value")
    console.log "vq: " + vq
    $.getJSON( "http://gdata.youtube.com/feeds/api/videos/", { vq: vq, "max-results": 5, alt: "json" }, (json)->
      result_list = $.map( json.feed.entry, (item)->
        title = item.title["$t"]
        movie_url = item["media$group"]["media$content"][0].url
        console.log movie_url
        thumb_url = item["media$group"]["media$thumbnail"][1].url
        "<li>"+
          "<button type='button'>"+
            "<a href='#{movie_url}' class='button_link'>#{title}</a><br /><img src='#{thumb_url}' />"+
          "</button>"+
        "</li>"
      )
      $("#search_result_list").empty()
      $("#search_result_list").append( result_list.join("") )
      $("#search_result_list").map ->
        $("button",this).click ->
          number = $("#search_youtube_step_number").attr("value")
          a_tag = $(".button_link",this)
          href = a_tag.attr("href")
          $("#recipe_step_#{number} .movie_selecter").attr("value", href)
          console.log href
          $("#search_youtube_area").css("display","none")
        this
    )
  )

  $(".movie_button").click ->
    step_number = $(this).next().attr("value")
    $("#search_youtube_step_number").attr( "value", step_number )
    $("#search_youtube_area").css("display","block")

  $("#search_youtube_area_close_button").click ->
    $("#search_youtube_area").css("display","none")
