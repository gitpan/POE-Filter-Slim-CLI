# tests based on POE::Filter::Line's

use strict;
use lib qw(t);

#sub POE::Kernel::ASSERT_DEFAULT () { 1 }
#sub POE::Kernel::TRACE_DEFAULT  () { 1 }
#sub POE::Kernel::TRACE_FILENAME () { "./test-output.err" }

use TestFilter;
use Test::More tests => 2 + $COUNT_FILTER_INTERFACE + $COUNT_FILTER_STANDARD;

use_ok("POE::Filter::Slim::CLI");
test_filter_interface("POE::Filter::Slim::CLI");

{
  my $filter = POE::Filter::Slim::CLI->new();
  isa_ok($filter, 'POE::Filter::Slim::CLI');

  test_filter_standard(
    $filter,
    [ "test with spaces\x0D", "foo\x0A", "foo%20bar baz\x0D\x0A" ],
    [ [ 'test', 'with', 'spaces' ], [ 'foo' ], [ 'foo bar', 'baz' ] ],
    [ "test with spaces\x0D\x0A", "foo\x0D\x0A", "foo%20bar baz\x0D\x0A" ],
  );
}
