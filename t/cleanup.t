# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

use Test;
BEGIN { $| = 1; plan tests => 12, onfail => sub { $? = 1 if $ENV{AEGIS_TEST} } }
END {print "not ok 1\n" unless $loaded;}
use Test::Cmd;
$loaded = 1;
ok(1);

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

my($test, $wdir, $ret);

$test = Test::Cmd->new(workdir => '');
ok($test);
$wdir = $test->workdir;
ok($wdir);
$ret = $test->write('file1', <<EOF);
Test file #1.
EOF
ok($ret);

$test->cleanup;
ok(! -d $wdir);

$test = Test::Cmd->new(workdir => '');
ok($test);
$wdir = $test->workdir;
ok($wdir);
$ret = $test->write('file2', <<EOF);
Test file #1.
EOF
ok($ret);
$ret = chdir($wdir);
ok($ret);
$ret = chmod(0444, 'file2');
ok($ret);
$ret = chmod(0555, $wdir);
ok($ret);

$test->cleanup;

ok(! -d $wdir);