package inc::MakeMaker;

use Moose;
#use Devel::CheckLib;

extends 'Dist::Zilla::Plugin::MakeMaker::Awesome';

#override _build_MakeFile_PL_template => sub {
#	my ($self) = @_;
#	my $template = "use Devel::CheckLib;\ncheck_lib_or_exit(lib => 'cityhash');\n".super();
#
#	return $template
#};

override _build_WriteMakefile_args => sub {
	return +{
		%{ super() },
#		LIBS	=> ['-lcityhash'],
		INC	=> '-I.',
		XSOPT	=> '-C++',
		CC	=> 'g++',
		OBJECT	=> '$(O_FILES)',
	}
};

__PACKAGE__ -> meta -> make_immutable;
