# $Id$
use ExtUtils::MakeMaker;

eval "use Test::Manifest 1.14";

WriteMakefile(
	'NAME'	       => 'File::Find::Closures',
	'VERSION_FROM' => 'lib/Closures.pm',
	'LICENSE'      => 'perl',
	'AUTHOR'       => 'brian d foy <bdfoy@cpan.org>',


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
