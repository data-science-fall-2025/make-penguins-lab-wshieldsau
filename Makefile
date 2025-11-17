rexec = R CMD BATCH --no-save --no-restore

all: penguins

.PHONY : penguins
penguins: output/penguin_report.html

output/penguin_report.html: output/penguin_class.csv analysis/penguin_report.qmd output/penguin_pairs.png
	quarto render analysis/penguin_report.qmd
	mv ./analysis/penguin_report.html ./output/penguin_report.html

output/penguin_class.csv: analysis/classify_penguins.R
	$(rexec) $< output/classify_penguins.Rout

output/penguin_pairs.png: analysis/plot_penguin.R
	$(rexec) $< output/plot_penguin.Rout

.PHONY: clean
clean:
	rm -f ./output/penguin_class.csv
	rm -f ./output/penguin_report.html
	rm -f ./output/penguin_pairs.png