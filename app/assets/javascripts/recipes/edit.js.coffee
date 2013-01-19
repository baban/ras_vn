window.onload = ->
  genre_initializer = ->
    sctr = $("#recipe_recipe_food_id")
    sctr2 = null

    clone_selecter=->
      sctr.show()
      sctr2 = $(sctr).clone(true)
      sctr2.insertAfter(sctr)
      sctr.hide()
      genre_name = $("select#recipe_genre_selecter option:selected").text()
      $("optgroup[label!='#{genre_name}']",sctr2).remove()
      genre_name

    clone_selecter()
    $(sctr2).val( $("#hidden_recipe_food_id").val() )
    # when change selecter
    $("#recipe_genre_selecter").change ->
      $("select#recipe_genre_selecter option:selected").each ->
        sctr2.remove()
        genre_name = clone_selecter()
        $("optgroup[label='#{genre_name}'] option:first-child",sctr2).select()
  genre_initializer()
  
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
      '<td class="ingredient_calory"><input type="text" name="foodstuffs[][calory]" value="" placeholder="kcal"></td>'+
      '<td class="ingredient_close_button"><p class="close"><input type="button" value="☓"></p></td>'+
    '</tr>';
    foodstuff_close_button_check()
    return s;

  # add recipe foodstuffs
  $("#add_foodstuffs_row").click ->
    $("#foodstuffs").append(food_stuff_row(4))

  movie_button_click = ->
    step_number = $(this).next().attr("value")
    $("#search_youtube_step_number").attr( "value", step_number )
    $("#search_youtube_area").css( { display:"block", opacity: 0.0 } )
    $("#search_youtube_area").animate( { opacity: 1.0 }, { duration: 400 } )

  # add recipe steps
  $("#add_steps").click ->
    i = $("#steps section").size() + 1
    iimg_a = $('<div />').addClass('iimg_a')
               .append( $('<p />').append( $('<label />').text('Image') ) )
	       .append( $('<input />').attr('type','file').attr('size',15).attr('name',"recipe_steps[][image]") )
    movie_button = $('<input />').attr('type','button').addClass('movie_button').attr('value','Movie Url')
    movie_button.click movie_button_click
    movie_button_field = $('<div />').addClass('movie_button_field')
                           .append( $('<p />').append( $('<label />')
                           .append( $('<p />').attr("style","color: red;").text('Tìm video dạy cách nấu ăn trên Youtube:') ) ) )
                           .append( $('<p />').attr("style","width: 412px; color: #008000;").text('Cách tìm: Click vào Movie url -> Nhập tên món ăn -> Enter -> Click vào video muốn tìm.'))
                           .append( $('<input />').attr('type','text').attr('name','recipe_steps[][movie_url]').attr('id',"recipe_steps_#{i}_movie_url") )
                           .append( movie_button )
                           .append( $('<input />').attr('type','hidden').attr('id',"step_number_#{i}").attr('name',"step_number_#{i}").attr('value', i ) )
    section = $('<section />').attr('class','rec_cat7 clearfix')
                .append( $("<h3 />").addClass('material_txt').text("BƯỚC #{i}") )
                .append( $("<textarea />").addClass('step_edit_area').attr('name','recipe_steps[][content]') )
                .append( iimg_a )
                .append( movie_button_field )
    $("#steps").append(section)

  # open window youtupe movies
  $(".movie_button").click movie_button_click

  # add youtupe movieto recipe step
  search_youtube = ->
    vq = $("#search_youtube_text").attr("value")
    step_number = $("#search_youtube_step_number").attr("value")
    $.getJSON( "/recipes/youtube", { vq: vq, "max-results": 5, alt: "json" }, (json)->
      make_list = ->
        $.map( json.feed.entry, (item)->
          title = item.title["$t"]
          movie_url = item["media$group"]["media$content"][0].url
          thumb_url = item["media$group"]["media$thumbnail"][1].url
          button = $("<button />").attr("type","button")
                     .append( $("<a />").attr("href",movie_url).addClass("button_link").text(title) )
                     .append( "<br />" )
                     .append( $("<img />").attr("src",thumb_url) )
          button.click ->
            number = $("#search_youtube_step_number").attr("value")
            href = $(this).children().attr("href")
            $("#recipe_steps_#{number}_movie_url").val( href )
            $("#search_youtube_area").animate( { opacity: 0.0 }, { duration: 300, complete: -> $(this).css("display", "none") } )
          
          li = $("<li/>").append(button)
          $("#search_result_list").append( li )
        )
      $("#search_result_list").empty()
      make_list()
    )
    false

  # button action
  $("#search_youtube_button").click search_youtube

  # enter key action
  $("#search_youtube_text").keydown (evt)->
    charCode = evt.charCode || evt.which || evt.keyCode
    if (Number(charCode) == 13 || Number(charCode) == 3)
      search_youtube()
      false
    else
      true

  $("#search_youtube_area_close_button").click ->
    $("#search_youtube_area").animate( { opacity: 0.0 },
      { duration: 300, complete: -> $(this).css("display", "none") } )

