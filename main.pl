#!/usr/bin/env perl

use v5.42;
use utf8;
binmode STDOUT, ':encoding(UTF-8)';
binmode STDIN, ':encoding(UTF-8)';
use File::Spec;
# use Term::ReadKey;


sub printHelp {
    say "Usage: c-to-fdg SOURCE DEST";
    say "  or:  c-to-fdg SOURCE DIRECTORY";
    say "Convert C code SOURCE to FDG and rename it to DEST, or moves it to DIRECTORY.";
}


die &printHelp if @ARGV != 2;
my $source = $ARGV[0];
my $dest = $ARGV[1];

if (-d $dest) {
  $dest = File::Spec->catfile( $dest, $source =~ s/\..*\Z/.fgd/r );
}

# TODO: Figure out with y/n prompt
if (-e $dest) {
    print "Sure you want to overwrite $dest [y/N]? ";

    ...

    # ReadMode 4;
    # my $key = '';
    # while (($key = ReadKey(-1)) ne 'y') {
    # }
    # ReadMode 0;
}
# open (my $dest_file, '>'

open (my $source_file, '<', $source)
    or die "Could not open source file: $!\n";

# open (my $dest_file, '>', $dest)
#     or die "Could not create dest file: $!\n";

say "Source: $source";
say "Dest: $dest";


# Put all lines from file into variable
my $source_code = join '', <$source_file>;
say $source_code;


# Replacing structs with .FDG classes
$source_code =~ s{
(?: \s* //\s* (?<struct_comment>[^\n]*) )?

(?<struct>
    \s* struct\s+ (?<struct_name>\w+\d?)\s* \{
        (?<struct_content>.*?)
    \};
)

}{\@PointClass size(-16 -16 -32, 16 16 32) = $+{struct_name} : "$+{struct_comment}"
[
    $+{struct_content}
]

}mgxs;

# Replacing struct fields with .FDG class fields
$source_code =~ s{
    \s* (?<variable_type>[\w\s*::<>]+?)\s+ (?<var_name>\w+) (?:\s* =\s* (?<default_value>\w+?))?; (?:\s* //\s* (?<var_comment>[^\n]+))?
}{
    $+{var_name}($+{variable_type}): : $+{default_value} : "$+{var_comment}"
}mgxs;

# Removing all exess lines
$source_code =~ s{
^\s*
( \#.+ | //.*? | .*?; (\s*//.*)? | )
\R
}{}mgx;

# Renaming filetypes
$source_code =~ s/\((const )?int\)/(integer)/g;
$source_code =~ s/\((const )?char\*\)/(string)/g;


say $source_code;


open (my $dest_file, '>', $dest)
    or die "Could not create dest file: $!\n";
print $dest_file $source_code;
