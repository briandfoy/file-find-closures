# $Id$
package File::Find::Closures;
use strict;

use vars qw( $VERSION @EXPORT_OK %EXPORT_TAGS );

use Carp qw(carp croak);
use Exporter;
use File::Spec::Functions qw(canonpath no_upwards);
use UNIVERSAL qw(isa);

$VERSION = "0.010_01";

@EXPORT_OK   = ();
%EXPORT_TAGS = ();

sub _unimplemented { croak "Unimplemented function!" }

=head1 NAME

File::Find::Closures - functions you can use with File::Find

=head1 SYNOPSIS

	use File::Find;
	use File::Find::Closures qw(:all);

	my( $list_reporter, $wanted ) = find_by_name( qw(README) );

	File::Find::find( $wanted, @directories );
	File::Find::find( { wanted => $wanted, ... }, @directories );

	my @readmes = $list_reporter->();

=head1 DESCRIPTION

SOME PARTS ARE NOT IMPLEMENTED YET!  THIS IS ALPHA ALPHA SOFTWARE: A
MERE SHELL OF AN IDEA.

When I use File::Find, I have two headaches---coming up with the
\&wanted function to pass to find(), and acculumating the files.

This module provides the \&wanted functions as a closures that I can
pass directly to find().  Actually, for each pre-made closure, I
provide a closure to access the list of files too, so I don't have to
create a new array to hold the results.

The filenames are the full path to the file as reported by File::Find.

Unless otherwise noted, the reporter closure returns a list of the
filenames in list context and an anonymous array that is a copy (not a
reference) of the original list.  The filenames have been normalized
by File::Spec::canonfile unless otherwise noted.  The list of files
has been processed by File::Spec::no_upwards so that "." and ".." (or
their equivalents) do not show up in the list.


=head2 The closure factories

Each factory returns two closures.  The first one is for find(),
and the second one is the reporter.

=over 4

=item find_by_min_size( SIZE );

Find files whose size is equal to or greater than SIZE bytes.

=cut

sub find_by_min_size
	{
	my $min   = shift;
	
	my @files = ();
	
	sub { push @files, canonpath( $File::Find::name ) if -s $_ >= $min },
	sub { @files = no_upwards( @files ); wantarray ? @files : [ @files ] }
	}

=item find_by_max_size( SIZE );

Find files whose size is equal to or less than SIZE bytes.

=cut

sub find_by_max_size
	{
	my $min   = shift;
	
	my @files = ();
	
	sub { push @files, canonpath( $File::Find::name ) if -s $_ <= $min },
	sub { @files = no_upwards( @files ); wantarray ? @files : [ @files ] }
	}

=item find_by_zero_size();

Find files whose size is equal to 0 bytes.

=cut

sub find_by_zero_size
	{
	my $min   = shift;
	
	my @files = ();
	
	sub { push @files, canonpath( $File::Find::name ) if -s $_ == 0 },
	sub { @files = no_upwards( @files ); wantarray ? @files : [ @files ] }
	}

=item find_by_directory_contains( @names );

Find directories which contain files with the same name
as any of the values in @names.

UNIMPLEMENTED!

=cut

sub find_by_directory_contains
	{
	_unimplemented();
	}

=item find_by_name( @names );

Find files with the names in @names.  The result is the name returned
by $File::Find::name normalized by File::Spec::canonfile().

In list context, it returns the list of files.  In scalar context,,
it returns an anonymous array.

This function does not use no_updirs, so if you ask for "." or "..",
that's what you get.

=cut

sub find_by_name
	{
	my %hash  = map { $_, 1 } @_;
	my @files = ();
	
	sub { push @files, canonpath( $File::Find::name ) if exists $hash{$_} },
	sub { wantarray ? @files : [ @files ] }
	}

=item find_by_regex( REGEX );

Find files whose name match REGEX.

This function does not use no_updirs, so if you ask for "." or "..",
that's what you get.

=cut

sub find_by_regex
	{
	my $regex = shift;
	
	unless( isa( $regex, 'Regexp' ) )
		{
		carp "Argument must be a regular expression";
		}
		
	my @files = ();
	
	sub { push @files, canonpath( $File::Find::name ) if m/$regex/ },
	sub { wantarray ? @files : [ @files ] }
	}

=item find_by_owner( OWNER_NAME | OWNER_UID );

Find files that are owned by the owner with the name OWNER_NAME.
You can also use the owner's UID.

UNIMPLEMENTED!

=cut

sub find_by_owner
	{
	_unimplemented();
	}

=item find_by_group( GROUP_NAME | GROUP_GID );

Find files that are owned by the owner with the name GROUP_NAME.
You can also use the group's GID.

UNIMPLEMENTED!

=cut

sub find_by_group
	{
	_unimplemented();
	}

=item find_by_executable();

Find files that are executable.  This may not work on some operating
systems (like Windows) unless someone can provide me with an
alternate version.

UNIMPLEMENTED!

=cut

sub find_by_executable
	{
	_unimplemented();
	}

=item find_by_writeable();

Find files that are writable.  This may not work on some operating
systems (like Windows) unless someone can provide me with an
alternate version.

UNIMPLEMENTED!

=cut

sub find_by_writeable
	{
	_unimplemented();
	}

=item find_by_umask( UMASK );

Find files that fit the umask UMASK.  The files will not have those
permissions.

UNIMPLEMENTED!

=cut

sub find_by_umask
	{
	_unimplemented();
	}

=item find_by_modified_before( EPOCH_TIME );

Find files modified before EPOCH_TIME, which is in seconds since
the local epoch (I may need to adjust this for some operating
systems).

UNIMPLEMENTED!

=cut

sub find_by_modified_before
	{
	_unimplemented();
	}

=item find_by_modified_after( EPOCH_TIME );

Find files modified after EPOCH_TIME, which is in seconds since
the local epoch (I may need to adjust this for some operating
systems).

UNIMPLEMENTED!

=cut

sub find_by_modified_after
	{
	_unimplemented();
	}

=item find_by_created_before( EPOCH_TIME );

Find files created before EPOCH_TIME, which is in seconds since
the local epoch (I may need to adjust this for some operating
systems).

UNIMPLEMENTED!

=cut

sub find_by_created_before
	{
	_unimplemented();
	}

=item find_by_created_after( EPOCH_TIME );

Find files created after EPOCH_TIME, which is in seconds since
the local epoch (I may need to adjust this for some operating
systems).

UNIMPLEMENTED!

=cut

sub find_by_created_after
	{
	_unimplemented();
	}


=back

=head1 ADD A CLOSURE

I want to add as many of these little functions as I can, so please
send me ones that you create!

You can follow the examples in the source code, but here is how you
should write your closures.

You need to provide both closures.  Start of with the basic subroutine
stub to do this.  Create a lexical array in the scope of the subroutine.
The two closures will share this variable.  Create two closures: one
of give to find() and one to access the lexical array.

	sub find_by_foo
		{
		my @args = @_;

		my @found = ();

		my $finder   = sub { push @found, $File::Find::name if ... };
		my $reporter = sub { @found };

		return( $finder, $reporter );
		}

The filename should be the full path to the file that you get
from $File::Find::name, unless you are doing something wierd,
like find_by_directory_contains().


Once you have something, send it to me at C<< <bdfoy@cpan.org> >>. You
must release your code under the Perl Artistic License.

=head1 TO DO

* more functions!

* need input on how things like mod times work on other operating
systems

=head1 SEE ALSO

L<File::Find>

Randal Schwartz's File::Finder, which does the same task, but
differently.

=head1 SOURCE AVAILABILITY

This source is part of a SourceForge project which always has the
latest sources in CVS, as well as all of the previous releases.

	http://sourceforge.net/projects/brian-d-foy/

If, for some reason, I disappear from the world, one of the other
members of the project can shepherd this module appropriately.

=head1 AUTHOR

brian d foy, C<< <bdfoy@cpan.org> >>

=head1 COPYRIGHT

Copyright (c) 2004, brian d foy, All Rights Reserved.

You may redistribute this under the same terms as Perl itself.

=cut

"Kanga and Baby Roo Come to the Forest";
