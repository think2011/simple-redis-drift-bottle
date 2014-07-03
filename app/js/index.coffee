$ ->
  $btnThrow    = $ '#btnThrow'
  $btnGet      = $ '#btnGet'
  $post        = $ '#post'
  $login       = $ '#login'
  $content     = $ '#content'
  $close       = $ '.btn-close'
  $msg         = $ '#msg'
  $textarea    = $ 'textarea'


  $close.on 'click', ->
    $(@).parent().removeClass 'active'


  $post.find('button').on 'click', ->
    $.post '/post', content: $textarea.val()
    return false


  $btnThrow.on 'click', ->
    $post.addClass 'active'
    $textarea.val('').focus()


  $btnGet.on 'click', ->
    $msg.text '正在拔瓶子..'
    $content.addClass 'active'

    $.post '/', (data) ->
      if data.code is 0
        $msg.text data.msg
      else
        $msg.text data.msg.content




