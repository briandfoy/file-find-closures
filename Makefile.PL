# $Id$
use ExtUtils::MakeMaker;

eval "use Test::Manifest";

unless( $@ )
	{
	* ExtUtils::MM_Any::test_via_harness = sub
		{
		my($self, $perl, $tests) = @_;
		
		return qq|\t$perl "-MTest::Manifest" | .
			qq|"-e" "run_t_manifest(\$(TEST_VERBOSE), '\$(INST_LIB)', | .
			qq|'\$(INST_ARCHLIB)')"\n|;
		}
	}

WriteMakefile(
	'NAME'	       => 'File::Find::Closures',
	'VERSION_FROM' => 'lib/Closures.pm',

	'PREREQ_PM'    => {
		'File::Find' => '0',
		},

	'PM'           => {
		'lib/Closures.pm'         => '$(INST_LIBDIR)/Closures.pm',
		},

	'MAN3PODS'     => {
		'lib/Closures.pm' => '$(INST_MAN3DIR)/File::Find::Closures.3',
		},

	clean  => { FILES    => q|File-Find-Closures-*| },

	);
