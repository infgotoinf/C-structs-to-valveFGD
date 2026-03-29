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

# Remove all macro definitions and includes if any
$source_code =~ s/^\s*#.*$//gm;



$source_code =~ s{
(?:
    (?:
        \s* //\s* (?<struct_comment>[^\n]*) \n
    )?

    (?<struct>
        \s* struct\s+ (?<struct_name>\w+\d?)\s* \{
            .*?
            \s* (?<var_type>\w+)\s+ (?<var_name>\w+);
            .*?
        \};
    )
)

}{\@PointClass size(-16 -16 -32, 16 16 32) = $+{struct_name} : "$+{struct_comment}"
[
    $+{var_name}($+{var_type})
]

}mgxs;

say $source_code;


open (my $dest_file, '>', $dest)
    or die "Could not create dest file: $!\n";
print $dest_file $source_code;
