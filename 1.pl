#usr/bin/perl -w
my ($file) = @ARGV;
open IN, "$file" or die "$!";
while (my $line=<IN>) {
	chomp($line);
	if ($line =~/(\w+)=>(.*)/) {
		my $key = $1;
		my $value = $2;
		print "#$key\n$value\n";
	}
}
close IN;
