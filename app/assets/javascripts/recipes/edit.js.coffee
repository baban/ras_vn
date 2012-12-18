$(window).load ->
  genre_initializer = ->
    sctr = $("#recipe_recipe_food_id")
    sctr.show()
    sctr2 = $(sctr).clone(true)
    sctr2.insertAfter(sctr)
    sctr.hide()
    $("optgroup:not(:first-child)",sctr2).remove()
    #
    $("#recipe_genre_selecter").change ->
      $("select#recipe_genre_selecter option:selected").each ->
        sctr2.remove()
        sctr.show()
        sctr2 = sctr.clone()
        sctr2.insertAfter(sctr)
        sctr.hide()
        labelname = $(this).text()
        $("optgroup[label!='"+labelname+"']",sctr2).remove()
  genre_initializer()

  recipe_food_id_select = ->
    if $("#recipe_draft_recipe_food_id").val()
      $("#recipe_draft_recipe_food_id").css( "display", "inline" )
  recipe_food_id_select()  
  
  # delete recipe foodstuffs
  foodstuff_close_button_check=->
    $(".ingredient_close_button input").click ->
      tr = $(this).parent().parent().parent()
      $( "input:text", tr ).val("")
      tr.slideUp()
  foodstuff_close_button_check()

  food_stuff_row = (i)->
    s = 
    '<tr class="ingredient_row clearfix">'+
      '<td class="ingredient_name"><input type="text" name="foodstuffs[][name]" value="" placeholder="tên thực phẩm"></td>'+
      '<td class="ingredient_quantity"><input type="text" name="foodstuffs[][amount]" value="" placeholder="dung lượng"></td>'+
      '<td class="ingredient_close_button"><p class="close"><input type="button" value="☓"></p></td>'+
    '</tr>';
    foodstuff_close_button_check()
    return s;

  # add recipe foodstuffs
  $("#add_foodstuffs_row").click ->
    $("#foodstuffs").append(food_stuff_row(4))

  # add recipe steps
  $("#add_steps").click ->
    s = 
    '<section class="rec_cat5 clearfix">'+
      '<h3 class="material_txt">mới BƯỚC</h3>'+
      '<textarea class="step_edit_area" name="steps[]"></textarea>'+
    '</section>';
    $("#steps").append(s)

  # open window youtupe movies
  $(".movie_button").click ->
    console.log "movie_button"
    step_number = $(this).next().attr("value")
    console.log step_number
    $("#search_youtube_step_number").attr( "value", step_number )
    $("#search_youtube_area").css( { display:"block", opacity: 0.0 } )
    $("#search_youtube_area").animate( { opacity: 1.0 }, { duration: 400 } )

  # add youtupe movieto recipe step
  search_youtube = ->
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
          console.log "#recipe_step_#{number}_movie_url"
          console.log href
          $("#recipe_steps_#{number}_movie_url").val( href )
          $("#search_youtube_area").animate( { opacity: 0.0 }, 
            { duration: 300, complete: -> $(this).css("display", "none") } )
        this
    )

  # button action
  $("#search_youtube_button").live( "click", search_youtube )

  # enter key action
  $("#search_youtube_text").keydown (evt)->
    charCode = evt.charCode || evt.which || evt.keyCode
    console.log "charCode : " + charCode
    if (Number(charCode) == 13 || Number(charCode) == 3)
      search_youtube()
      false
    else
      true

  $("#search_youtube_area_close_button").click ->
    $("#search_youtube_area").animate( { opacity: 0.0 },
      { duration: 300, complete: -> $(this).css("display", "none") } )

