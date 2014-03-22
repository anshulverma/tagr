flatiron = require 'flatiron'
path     = require 'path'
optimist = require 'optimist'

app = module.exports = flatiron.app

require('pkginfo')(module, 'name', 'version')

app.use(
  flatiron.plugins.cli,
  {
    usage: require('./usage')
    version: true
    argv:
      tag:
        description: 'tag ID that should be applied to version a new release'
        alias: 't'
        string: true
      message:
        description: 'optional message to add to your new tag commit'
        alias: 'm'
        string: true
      help:
        description: 'print this help information'
        alias: 'h'
      version:
        description: 'prints version of tagr that you are running'
        alias: 'v'
    dir: path.join(__dirname, 'commands')
    prompt:
      override: true
      properties:
        tag:
          decription: 'Enter new tag id'
          type: 'string'
          pattern: /^[0-9]+\.[0-9]+\.[0-9]+$/
          message: 'Tag must be of the form N.N.N (where N is a number)'
          required: true
          hidden: false
  })

app.ready = false;

app.start = (callback) ->
  app.init (err) ->
    if err?
      app.welcome()
      app.showError app.argv._.join ' ', err
      return callback(err)
    app.welcome()
    minor = process.version.split('.')[1];

    if parseInt(minor, 10) % 2
      app.log.warn 'You are using unstable version of node.js. You may experience problems.'
#    app.prompt.override = optimist.argv
    return app.exec app.argv._, callback

app.exec = (command, callback) ->
  execCommand = (err) ->
    if err then return callback(err)
    fullCommand = command.join(' ')
    if fullCommand then app.log.info 'Executing command ' + fullCommand.magenta
    app.router.dispatch 'on', fullCommand, app.log, (err, shallow) ->
      if err?
        app.showError fullCommand, err, shallow
        return callback(err)
      callback();
  try
    return if app.ready then execCommand() else app.setup(execCommand)
  catch e
    app.showError command.join(' '), e


app.setup = (callback) ->
  if app.ready is true
    return callback()
  app.ready = true;
  callback()

app.welcome = () ->
  app.log.info 'Welcome to ' + 'Tagger'.grey + ' utility'

app.showError = (command, err, shallow, skip) ->
  app.log.error 'Error: ' + 'Unable to execute "' + command + '" [ ' + err.message + ' ]'
  app.log.error err.stack

