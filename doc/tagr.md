tagr(1) -- application tagger utility
=====================================

## SYNOPSIS

    tagr { -v | -h } [command [-t <tag>] [-m <message>]]

## VERSION

@VERSION@

## DESCRIPTION

tagr is a command line utility to easily push releases out to any sort
of repository. It, by default, tags each release with an appropriate
version id.

The release version id is configurable. It is of the form `N.N.N` (where N
is a number). By default, the version auto increments between subsequent
releases. If `--version` argument is used, you can override the next
version id.

Run `tagr help` to get a list of available commands.

## INTRODUCTION

You probably got tagr because you are tired of manually tagging and
pushing releases. tagr is here to help with all that and more.

Execute `tagr new` to create a new tag of your application and follow
directions form the prompt. Check out `tagr-new(1)` for more info.

To get list of tags, execute `tagr list`. It will also print details
associated with each tag. For more details, visit: `tagr-list(1)`.

`tag show` shows the latest release and all the commits associated with
it (check out `tagr-show(1)` for more details).

For getting a peek at the upcoming release, try `tag next`. It will give
you a list of commits that will be a part of the next release (check out
`tagr-next(1)` for more info).

## CONFIGURATION

tagr can support any language or repository, as long as it is configured
properly.

It comes with support for following languages / package managers:

* node.js (npm)

There is also support for tagging repositories of following types:

* git

### Adding support of new language / package manager

--TODO--

### Adding support for new repository

--TODO--

## CONTRIBUTIONS

There will always be a need for adding support for new languages,
package managers or repository.

When you do make an edit, please make sure to keep documentation in sync
with your edits. Tests are also required to validate your changes.

Contributors are listed in npm's `package.json` file.  You can view them
easily by doing `npm view tagr contributors`.

If you would like to contribute, but don't know what to work on, check
the issues list or ask on the mailing list.

* <https://github.com/anshulverma/node-tagged-release/issues>
* <node-tagged-release@googlegroups.com>

## BUGS

When you find issues, please report them:

* web:
  <https://github.com/anshulverma/node-tagged-release/issues>
* email:
  <node-tagged-release@googlegroups.com>>

Be sure to include *all* of the output from the tagr command that didn't work
as expected.  The `npm-debug.log` file is also helpful to provide.

## AUTHOR

[Anshul Verma](http://anshulverma.github.io/) ::
[anshulverma](https://github.com/anshulverma) ::
[@anshulverma](http://twitter.com/anshulverma)

## SEE ALSO

tagr-new(1), tagr-list(1), tagr-show(1), tagr-next(1)

