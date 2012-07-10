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
  
  $(".image_selecter").click ->
    $(this).next().css("display","inline")

  $(".movie_selecter").click ->
    $(this).next().css("display","inline")
