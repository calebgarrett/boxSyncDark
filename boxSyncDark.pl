#!/usr/bin/perl
#
# Fix Box Sync menu bar icons so they look good in Dark Mode
 
# use strict;
use warnings;
use File::Copy;
 
# --- Variables --- #
my $app_dir = "/Applications";
my $box_app = "$app_dir/Box Sync.app";
 
# If the file is a symlink, gets its target
if ( -l $box_app )  {
    $box_app_bundle = readlink $box_app;
} else {
    $box_app_bundle = $box_app;
}
my $box_resources = "$box_app_bundle/Contents/Resources";
# my $box_resources = "/Users/ctgarret/Downloads/working";
 
print "Opening $box_resources\n";
opendir(BOXAPP, $box_resources) or die "Cannot open $box_resources";
@files = readdir(BOXAPP);
closedir(BOXAPP);
 
chdir($box_resources);
 
# Copy the "_pressed" icon to the main icon since "_pressed" is white
# and looks good in Yosemite Dark Mode
foreach $icon (@files){
    if ($icon =~ /menubar_.*_pressed(\@2x)?.png/) {
        $renamed = $icon;
        $renamed =~ s/_pressed//;
        copy( $icon , $renamed );
        # print "$icon renamed to $renamed\n"
    }
}
