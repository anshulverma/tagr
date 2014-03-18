flatiron = require 'flatiron'
path     = require  'path'

app = module.exports = flatiron.app

require('pkginfo')(module, 'name', 'version')

app.use(
  flatiron.plugins.cli,
  {
    usage: require('./usage'),
    version: true,
    argv: {
      version: {
        alias: 'v',
        description: 'version id',
        string: true
      },
      message: {
        alias: 'm',
        description: 'optional message to add to your version commit',
        string: true
      }
    },
    dir: path.join(__dirname, 'commands')
  });

app.cmd('hello', ->
  app.prompt.get('name', (err, result) ->
    app.log.info('hello '+result.name+'!')))

app.initialized  = false;

app.start = (callback) ->
  app.init (err) ->
    if typeof err isnt 'undefined'
      app.welcome()
      app.showError app.argv._.join ' ', err
      return callback(err)
    app.welcome()
    minor = process.version.split('.')[1];

    if parseInt(minor, 10) % 2
      app.log.warn 'You are using unstable version of node.js. You may experience problems.'
    return app.exec app.argv._, callback

app.exec = (command, callback) ->
  execCommand = (err) ->
    if err then return callback(err)
    fullCommand = command.join(' ')
    if fullCommand then app.log.info 'Executing command ' + fullCommand.magenta
    app.router.dispatch 'on', fullCommand, app.log, (err, shallow) ->
      if typeof err isnt 'undefined'
        app.showError fullCommand, err, shallow
        return callback(err)
      callback();
  try
    return if app.initialized then execCommand() else app.setup(execCommand)
  catch e
    app.showError command.join(' '), e
  finally
    app.cleanup()


app.setup = (callback) ->
  if app.initialized is true
    return callback()
  app.initialized = true;
  callback()

app.welcome = () ->
  app.log.info 'Welcome to ' + 'Tagger'.grey + ' utility'

app.showError = (command, err, shallow, skip) ->
  app.log.error 'Error: ' + 'Unable to execute "' + command + '" [ ' + err.message + ' ]'
  app.log.error err.stack

app.cleanup = () ->
  app.log.info 'Exiting...'
