filename=report

all:
	pdflatex ${filename}.tex

pdf: ps
	ps2pdf ${filename}.ps

ps: dvi
	dvips ${filename}.dvi

dvi:
	latex ${filename}
	bibtex ${filename}
	makeglossaries ${filename}
	latex ${filename}
medit:
	mate *.tex

ledit:
	gedit *.tex

readpdf:
	open ${filename}.pdf &

clean:
	rm -f ${filename}.ps ${filename}.pdf ${filename}.log ${filename}.aux ${filename}.out ${filename}.dvi ${filename}.bbl ${filename}.blg

bib:
	bibtex ${filename}

glossaries:
	makeglossaries ${filename}