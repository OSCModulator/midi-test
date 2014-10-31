
midi = require('midi')

parse = (port, msg) ->
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

start = (port, virtual=no) ->
  midi_in = new midi.input()
  midi_in["open#{virtual and 'Virtual' or ''}Port"] port
  midi_in.on 'message', (deltaTime, msg) ->
    console.log("message received #{msg}")
#    console.log(parse(port, msg))

inputs = ->
  tmp = new midi.input()
  console.log("port count is #{tmp.getPortCount()}")

  for i in [0...tmp.getPortCount()]
    tmp.getPortName i

console.log('starting test')
list = inputs()

console.log("first port = #{list[0]}")
start(0)
