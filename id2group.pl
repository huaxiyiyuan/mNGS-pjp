#! /usr/bin/perl


my $group=shift;
my $id=shift;
my $out=shift;

my ($i,%hash);

open  OUT, ">$out" || die $!;


open IN,"$group" || die $!;
<IN>;
while(<IN>){
	chomp;
	s/\(\S+\)//g;
	my @aa=split /\t/,$_;
	
	$hash{$aa[0]}=$aa[1];
	
	
}
close IN;
	

open IN,"$id" || die $!;
<IN>;
while(<IN>){
	chomp;
	s/\(\S+\)//g;
	
	
	print OUT  "$_\t$hash{$_}\n";
	
	
}
close IN;
close OUT;




