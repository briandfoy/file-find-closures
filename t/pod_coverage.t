use Test::More;
my $module = "Test::Pod::Coverage";
eval "use $module 1.00";
plan skip_all => "$module 1.00 required for testing POD coverage" if $@;
all_pod_coverage_ok();