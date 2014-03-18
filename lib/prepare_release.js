var readline = require('readline');
var exec = require('exec-sync');
var fs = require('fs');

var pkg = require(process.env['VIZPROXY_DIR'] + '/package.json');

var hasUncommitedChanges = exec('git diff --shortstat') ? true : false;
if (hasUncommitedChanges) {
  console.error('Error: Please commit your changes before preparing release');
  process.exit(-1);
}

var hash = exec('git log -1 --format="%H"');
var lastTag = getLastTag();
var lastReleaseHash = lastTag ? exec('git rev-parse ' + lastTag) : exec('git rev-list --max-parents=0 HEAD');

if (hash != lastReleaseHash) {
  console.log('Preparing a new release for these commits:');
  console.log(exec('git log ' +
      '--graph ' +
      '--pretty=format:\'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\' ' +
      '--abbrev-commit ' +
      '--date=relative ' +
      lastReleaseHash + '..' + hash));

  fs.writeFileSync(process.env['VIZPROXY_DIR'] + '/../temp.txt', 'Following commits were added in this release: \n' +
      exec('git log ' +
          '--graph ' +
          '--pretty=format:\'%h - %s <%an>\' ' +
          '--abbrev-commit ' +
          lastReleaseHash + '..' + hash));
  console.log('Last version: ' + pkg.version);

  var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });
  var nextVersion = getNextVersion();
  rl.question('New version ['+ nextVersion +']?', function(newVersion) {
    newVersion = newVersion || nextVersion;
    verifyVersion(newVersion, nextVersion);

    console.log('Applying new version: ', newVersion);
    pkg.version = newVersion;
    fs.writeFileSync(process.env['VIZPROXY_DIR'] + '/package.json', JSON.stringify(pkg, null, '  '));

    rl.close();
    process.exit(1);
  });
} else {
  console.log('Found release version: ' + pkg.version);
  process.exit(0);
}

function getLastTag() {
  try {
    return exec('git describe --tags --abbrev=0');
  } catch (e) {
    return '';
  }
}

function getNextVersion() {
  return pkg.version.replace(/[0-9]*$/, function (minorVersion) {
    return Number(minorVersion) + 1;
  });
}

function verifyVersion(version, nextVersion) {
  var match =  version.match(/^[0-9]+\.[0-9]+\.[0-9]+$/);
  if (!match) {
    console.error('Error: Invalid version format: ' + version);
    process.exit(-2);
  }
  if (version.localeCompare(nextVersion) < 0) {
    console.error('Error: Version should always increment');
    process.exit(-3);
  }
  if (exec('git tag | grep ' + version) == version) {
    console.error('Error: Version tag already exists');
    process.exit(-4);
  }
}
