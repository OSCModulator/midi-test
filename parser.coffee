
@parse = (port, msg) ->
  channel = msg[0] % 16 + 1
  switch msg[0] / 16  # message type
    when 0xB
      ["/#{channel}/cc/#{msg[1]}", msg[2]/127.0]
    when 0x9  # note on
      ["/#{channel}/note/#{msg[1]}", msg[2]/127.0]
    when 0x8  # note off
      ["/#{channel}/note/#{msg[1]}", 0]
    when 0xE
      ["/#{channel}/pitchbend/", msg[1]/127.0]
    else
      ___ undefined, 'message:', msg...
