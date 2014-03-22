colors = require 'colors'

module.exports = [
  '  ___  __  __    __    __  __ '.cyan,
  '  /   /_/ / __  / __  /_  /_/ '.cyan,
  ' /   / / /_/ / /_/ / /__ / \\ '.cyan,
  '',

  'Application tagger utility',
  'https://github.com/anshulverma/node-tagged-release',
  '',

  'Usage:'.cyan.bold.underline,
  '',
  '  tagr { -v | -h } [command [-t <tag>] [-m <message>]]',
  '',

  'Common Commands:'.cyan.bold.underline,
  '',

  'To create a new tag'.cyan,
  '  tagr new',
  '',

  'To get list of tag(s)'.cyan,
  '  tagr list',
  '',

  'To get details of current tag'.cyan,
  '  tagr show',
  ''
];
