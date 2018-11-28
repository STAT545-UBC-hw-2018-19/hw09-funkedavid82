ALL := output.dot output.png

all: analysis1 analysis2

output.png: output.dot
	dot -Tpng < $< > $@
	
output.dot: Makefile makefile2dot.py
	python ./makefile2dot.py < $< >$@

	
clean: clean_analysis1 clean_analysis2

#analysis1

clean_analysis1:
	rm -f words.txt histogram.tsv histogram.png report.md report.html
	
analysis1: report.html	

report.html: report.rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'

histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

histogram.tsv: histogram.r words.txt
	Rscript $<

words.txt: /usr/share/dict/words
	cp $< $@

# words.txt:
#	Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'


#analysis2
clean_analysis2:
		rm -f words.txt Count_Vowels.tsv Count_Vowels.png Vowels.png report2.md report2.html output.dot output.png

analysis2: report2.html output.png		

report2.html: report2.rmd Count_Vowels.tsv Count_Vowels.png Vowels.png 
	Rscript -e 'rmarkdown::render("$<")'

Count_Vowels.png: Count_Vowels.tsv
	Rscript -e 'library(ggplot2); qplot(Number_of_Vowels, Freq, data=read.delim("$<"))+theme_bw()+xlab("Total number of Vowels")+ylab("Total number of English words"); ggsave("$@")'
	rm Rplots.pdf
	
Vowels.png: Count_Vowels.tsv
	Rscript -e 'library(ggplot2); ggplot(data=read.delim("$<"), aes(Number_of_Vowels, Freq))+theme_bw()+geom_col()+xlab("Total number of Vowels")+ylab("Total number of English words"); ggsave("$@")'
	rm Rplots.pdf

Count_Vowels.tsv: Count_Vowels.r words.txt
	Rscript $<