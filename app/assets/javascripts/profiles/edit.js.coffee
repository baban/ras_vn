$(window).load ->
  prefecture_selecteion = ->
    $("select#user_profile_prefecture_id option:selected").each ->
      labelname = $(this).text()
      $("select#user_profile_distinct_id optgroup").css( "display", "none" )
      $("select#user_profile_distinct_id optgroup[label='"+labelname+"']").css( "display", "block" )
  prefecture_selecteion()    

  $("select#user_profile_prefecture_id").change ->
    $("select#user_profile_prefecture_id option:selected").each ->
      labelname = $(this).text()
      $("select#user_profile_distinct_id optgroup").css( "display", "none" )
      $("select#user_profile_distinct_id optgroup[label='"+labelname+"']").css( "display", "block" )
