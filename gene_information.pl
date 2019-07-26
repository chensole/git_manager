#/usr/bin/perl -w
#use strict;
##################设计数据结构#################
#####目标：
########## 统计每条染色体上的基因数，总基因中编码蛋白的基因数目，转录本数目，外显子的数目及转录本的类型数目
#1.构造以染色体编号为key的外层hash结构,value为一个hash的引用
#2.内层hash的key为gene,transcript,protein_coding etc
#3.在内层hash中如果每重复一个key则加１

my ($file) = @ARGV;
open IN, "$file" or die "$!";
my %geneinfo;
my %transcript;
while (my $line=<IN>) {
	next if ($line =~/^#/);
	chomp;
	my @tmp = split (/\t/,$line);

# 创建一个哈希的哈希
	$geneinfo{$tmp[0]} -> {$tmp[2]}++;
	
	if ($tmp[2] eq "gene") {
		if($tmp[8]=~/gene_biotype "(protein_coding)"/) {
		
			$geneinfo{$tmp[0]} ->{$1}++;
		}
	
		if ($tmp[8] =~/gene_biotype "(\w+)"/) {
	
			$transcripts{$1}++;
		}


	}
}

close IN;

print "chr\tgene\tprotein\ttranscripts\texon\t";
foreach (sort keys %geneinfo) {
	#print "$_\t";
	
	 
	print "$_\t$geneinfo{$_}->{gene}\t$geneinfo{$_}->{protein_coding}\t$geneinfo{$_}->{transcripts}\t$geneinfo{$_}->{exon}\n";

}
print "\n";

foreach (sort keys %transcripts) {

	print "$_\t$transcripts{$_}\n";

}





