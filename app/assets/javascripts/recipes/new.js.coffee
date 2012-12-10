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

