colors = require 'colors'

module.exports = [
  '  ___  __  __    __    __  __ '.cyan,
  '  /   /_/ / __  / __  /_  /_/ '.cyan,
  ' /   / / /_/ / /_/ / /__ / \\ '.cyan,
  '',

  'Node.js application tagger utility',
  'https://github.com/anshulverma/node-tagged-release',
  '',

  'Usage:'.cyan.bold.underline,
  '',
  '  tagr [command] [--version <version>] [--message <message>]',
  '',

  'Common Commands:'.cyan.bold.underline,
  '',

  'To create a new version'.cyan,
  '  tagr new',
  '',

  'To get list of version(s)'.cyan,
  '  tagr list',
  '',

  'To get details of current version'.cyan,
  '  tagr current',
  ''
];
