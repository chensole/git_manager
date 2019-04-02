#/usr/bin/perl -w
#统计多音字及其频数
my ($file) = @ARGV;
open IN ,"$file" or die "$!";
my %hash;

while (my $line=<IN>) {
	chomp($line);
	#将单词合并为列表
	my @word=$line=~ /(\S+)\[[^\]]*\]/g;
	#将拼音合并为列表
	my @py=$line=~ /\S+\[([^\]]*)\]/g;
	#利用单词列表和拼音列表的一一对应关系生成哈希嵌套哈希的结构
	
	for($i=0;$i<@word;$i++) {
		#内哈希的值为每个音节出现的频数
		$hash{$word[$i]} -> {$py[$i]}++;
	
	
	}
	#if ($line=~ /(\S+)\[([^\]]*\])/g) {
	#		${$word{$1}}->{$2}++;
	
	#}

}
close IN;
#遍历哈希
foreach $k(keys %hash) {
	#生成内哈希的引用
	$pinyin = $hash{$k};
	my @arr = keys %{$pinyin};
	if (@arr>1) {
		$str="$k=>";
	
	foreach (sort @arr) {
		$str.="[$_],${$pinyin}{$_};";
	
	}
		print "$str\n";
	}


}
