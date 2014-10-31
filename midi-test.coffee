
midi = require('midi')
parser = require('./parser')

start = (midi_in, port, virtual=no) ->
  console.log("Opening port #{port} - #{midi_in.getPortName(port)}")

  midi_in["open#{virtual and 'Virtual' or ''}Port"] port
  midi_in.on 'message', (deltaTime, msg) ->
    console.log("message received #{parser.parse(port, msg)}")

test1 = ->
  midi_in1 = new midi.input()

  start(midi_in1, 0)
  console.log('Listening to port')

test2 = ->
  midi_in1 = new midi.input()
  midi_in2 = new midi.input()

  start(midi_in1, 0)
  console.log('Listening to port')

test1()
