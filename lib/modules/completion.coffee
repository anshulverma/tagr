if process.platform is 'win32' then return

complete = require 'complete'
output   = complete.output;

complete({
  program: 'tagr'
  commands:
    hello: (words, prev, cur) ->
      complete.output cur, ['abc', 'def']
    world:
      'hi': (words, prev, cur) ->
        complete.echo 'next'
  options:
    '--help': {},
    '-h': {},
    '--version': {},
    '-v': {}
})
