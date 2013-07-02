window.fbAsyncInit = ->
  FB.init
    appId: "153133848208607"
    status: true
    xfbml: true

  FB.getLoginStatus (response) ->
    if response.status is "connected"

      if $('#friends_select').length
        FB.api "/fql",
          q: "SELECT uid, name FROM user WHERE is_app_user = 0 AND uid IN ( SELECT uid2 FROM friend WHERE uid1 = me() )"
        , (response) ->
          friends_select(response.data)


      if $('#top_friends').length
        FB.api "/fql",
          q: "SELECT uid, name, pic_square FROM user WHERE is_app_user = 0 AND uid IN ( SELECT uid2 FROM friend WHERE uid1 = me() ) LIMIT 10"
        , (response) ->
          top_friends(response.data)


((d, s, id) ->
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  return  if d.getElementById(id)
  js = d.createElement(s)
  js.id = id
  js.src = "//connect.facebook.net/en_US/all.js"
  fjs.parentNode.insertBefore js, fjs
) document, "script", "facebook-jssdk"


# DROPDOWN OF FACEBOOK FRIENDS
friends_select = (list) ->
  $.each list, ->
    $("<option />",
      value: @uid
      text: @name
    ).appendTo $("#friends_select")

  $("#friends_select").select2({placeholder: "Start typing a friends name"})
# LIST WITH IMAGES OF 10 FRIENDS
top_friends = (list) ->
  $.each list, ->
    $("#top_friends").append "<div data-tooltip class=\"facebook-square tip-left\" style=\"background: url(" + @pic_square + ")\" title=\"" + @name + "\"></div>"
