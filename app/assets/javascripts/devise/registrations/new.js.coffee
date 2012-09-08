$(window).load ->
  $("select#user_user_profile_attributes_prefecture_id").change ->
    $("select#user_user_profile_attributes_prefecture_id option:selected").each ->
      labelname = $(this).text()
      $("select#user_user_profile_attributes_distinct_id optgroup").css( "display", "none" )
      $("select#user_user_profile_attributes_distinct_id optgroup[label='"+labelname+"']").css( "display", "block" )
