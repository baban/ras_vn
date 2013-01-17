window.onload = ->
  city_selecter = ->
    sctr = $("#user_profile_distinct_id")
    sctr.show()
    sctr2 = $(sctr).clone(true)
    sctr2.insertAfter(sctr)
    sctr.hide()
    $("optgroup:not(:first-child)",sctr2).remove()
    $("#user_profile_prefecture_id").change ->
      $("#user_profile_prefecture_id option:selected").each ->
        sctr2.remove()
        sctr.show()
        sctr2 = sctr.clone()
        sctr2.insertAfter(sctr)
        sctr.hide()
        labelname = $(this).text()
        $("optgroup[label!='"+labelname+"']",sctr2).remove()
  city_selecter()
