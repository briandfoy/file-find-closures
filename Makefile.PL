use ExtUtils::MakeMaker;

require 5.006;

eval "use Test::Manifest 1.14";

WriteMakefile(
	'NAME'	       => 'File::Find::Closures',
	'ABSTRACT'     => 'functions you can use with File::Find',

	'VERSION_FROM' => 'lib/File/Find/Closures.pm',
	'LICENSE'      => 'perl',
	'AUTHOR'       => 'brian d foy <bdfoy@cpan.org>',


	'PREREQ_PM'    => {
		'File::Find' => '0',
		},

	META_MERGE => {
		resourses => {
			repository => 'https://github.com/briandfoy/file-find-closures',
			},
		},

	);
	clean  => { FILES    => q|File-Find-Closures-*| },
