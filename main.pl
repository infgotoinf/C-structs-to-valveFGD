#!/usr/bin/env perl

use v5.42;
use utf8;
binmode STDOUT, ":encode(UTF-8)";
binmode STDIN, ":encode(UTF-8)";


sub printHelp {
    say "Usage: c-to-fdg SOURCE DEST";
    say "  or:  c-to-fdg SOURCE DIRECTORY";
    say "Convert C code SOURCE to FDG and rename it to DEST, or moves it to DIRECTORY.";
}


die &printHelp if @ARGV != 2;

open (my $source, '<', $ARGV[0])
    or die "Could not open source file: $!";
