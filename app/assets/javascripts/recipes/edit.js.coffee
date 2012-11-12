send_youtube_url_button = ( i, url )->
  console.log "url"
  console.log url

$(window).load ->
  $(".ingredient_close_button input").click ->
    tr = $(this).parent().parent().parent()
    $( "input:text", tr ).val("")
    tr.slideUp()

  food_stuff_row = (i)->
    s = 
    '<tr class="ingredient_row clearfix">'+
      '<td class="ingredient_name"><input type="text" name="foodstuffs[][name]" value="" placeholder="Thực phẩm"></td>'+
      '<td class="ingredient_quantity"><input type="text" name="foodstuffs[][amount]" value="" placeholder="Số tiền"></td>'+
      '<td class="ingredient_close_button"><form><input type="button" value="☓"></form></td>'+
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

  recipe_food_id_select = ->
    if $("#recipe_draft_recipe_food_id").val()
      $("#recipe_draft_recipe_food_id").css( "display", "inline" )
  recipe_food_id_select()
  
  $("#recipe_genre_selecter").change ->
    $("#recipe_draft_recipe_food_id").css( "display", "inline" )
    $("select#recipe_genre_selecter option:selected").each -> 
      labelname = $(this).text()
      $("#recipe_draft_recipe_food_id optgroup").css( "display", "none" )
      $("#recipe_draft_recipe_food_id optgroup[label='"+labelname+"']").css( "display", "block" )
  
  $("#search_youtube_button").live( "click", ->
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
        $("button", this).click ->
          number = $("#search_youtube_step_number").attr("value")
          a_tag = $(".button_link",this)
          href = a_tag.attr("href")
          $("#recipe_step_#{number} .movie_selecter").attr("value", href)
          console.log href
          $("#search_youtube_area").animate( { opacity: 0.0 }, 
            { duration: 300, complete: -> $(this).css("display", "none") } )
        this
    )
  )

  $(".movie_button").click ->
    step_number = $(this).next().attr("value")
    $("#search_youtube_step_number").attr( "value", step_number )
    $("#search_youtube_area").css( { display:"block", opacity: 0.0 } )
    $("#search_youtube_area").animate( { opacity: 1.0 }, { duration: 400 } )

  $("#search_youtube_area_close_button").click ->
    $("#search_youtube_area").animate( { opacity: 0.0 },
      { duration: 300, complete: -> $(this).css("display", "none") } )

  $("#search_youtube_text").keydown (evt)->
    charCode = evt.charCode || evt.which || evt.keyCode
    console.log "charCode : " + charCode
    if (Number(charCode) == 13 || Number(charCode) == 3)
      false
    else
      true
