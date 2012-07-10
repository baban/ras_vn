$(window).load ->
  $("#recipe_genre_selecter").change ->
    $("select#recipe_genre_selecter option:selected").each ->
      $("#recipe_recipe_food_id").css( "display", "inline" )
      labelname = $(this).text()
      $("#recipe_recipe_food_id optgroup").css( "display", "none" )
      $("#recipe_recipe_food_id optgroup[label='"+labelname+"']").css( "display", "block" )
