#!/usr/bin/env perl

use strict;
use warnings;

use Path::Tiny;
use autodie;


my $dir = path(".");

package Import
{
  # https://learn.perl.org/examples/read_write_file.html
  my $import_file = $dir->child("example.h");

  # Read in the entire contents of a file
  my $import_file_content = $import_file->slurp_utf8();

  # openr_utf8() returns an IO::File object to read from
  # with a UTF-8 decoding layer
  my $import_file_handle = $import_file->openr_utf8();

  # read line by line
  my @list;
  while( my $line = $import_file_handle->getline() )
  {
    # https://stackoverflow.com/questions/4505381/perl-read-line-by-line
    print $line;
    print $.;
    print $list.shift($.);
  }
}


package Export
{
  my $export_file = $dir->child("example.fdg");

  # Get a file_handle (IO::File object) you can write to
  # with a UTF-8 encoding layer
  my $export_file_handle = $export_file->openw_utf8();

  foreach my $line ( @Import::list ) {
    $export_file_handle->print($line . "\n");
  }
}
