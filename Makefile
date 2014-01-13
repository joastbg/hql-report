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
	rm -f *.ps *.pdf *.log *.aux *.out *.dvi *.bbl *.blg *.aux *.lot *.lof *.toc *.xdy *.gls *.glo *.glg *.acn *.idx *.ist
bib:
	bibtex ${filename}

glossaries:
	makeglossaries ${filename}
