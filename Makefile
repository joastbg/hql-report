filename=report
debug=report_debug.txt

NO_COLOR=\x1b[0m
OK_COLOR=\x1b[32;01m
ERROR_COLOR=\x1b[31;01m
WARN_COLOR=\x1b[33;01m

OK_STRING=$(OK_COLOR)[OK]$(NO_COLOR)
ERROR_STRING=$(ERROR_COLOR)[ERRORS]$(NO_COLOR)
WARN_STRING=$(WARN_COLOR)[WARNINGS]$(NO_COLOR)

define colorecho
      @tput setaf 6
      @echo "-->" $1
      @tput sgr0
endef

define pdfdone
      @tput bold
	  @tput setaf 2
      @echo $1
      @tput sgr0
endef

define psdone
      @tput bold
	  @tput setaf 3
      @echo $1
      @tput sgr0
endef

define starting
      @tput bold
	  @tput setaf 3
      @echo $1
      @tput sgr0
endef

.PHONY : pdf


#all: ps
#	$(call colorecho,"Preparing document" $(filename))
#	@pdflatex ${filename}.tex > report_debug.txt 2>&1
#	$(call doneecho,"Success! Wrote "$(filename)".pdf")

pdf: ps
	@ps2pdf ${filename}.ps > report_debug.txt 2>&1
	$(call pdfdone,"Success! Wrote "$(filename)".pdf")

ps: dvi
	@dvips ${filename}.dvi > report_debug.txt 2>&1
	$(call psdone,"Success! Wrote "$(filename)".ps")
dvi:
	@pdflatex -shell-escape ${filename}.tex > report_debug.txt 2>&1
	$(call colorecho,"latex ")
	@latex -shell-escape ${filename} > report_debug.txt 2>&1

	$(call colorecho,"bibtex ")
	@bibtex ${filename} > report_debug.txt 2>&1
	
	$(call colorecho,"makeglossaries")
	@makeglossaries ${filename} > report_debug.txt 2>&1

	$(call colorecho,"latex ")
	@latex -shell-escape ${filename} > report_debug.txt 2>&1
	
	$(call colorecho,"makeindex")
	@makeindex ${filename} > report_debug.txt 2>&1

	$(call colorecho,"latex")
	@latex -shell-escape ${filename} > report_debug.txt 2>&1

medit:
	@$(ECHO) -n compiling debug foo.cpp...
	mate *.tex

ledit:
	@tput setaf 6
	@echo "apa"
	@tput sgr0
	@echo "hej"
	$(call colorecho,"Linking with")

readpdf:
	open ${filename}.pdf &

clean:
	rm -f *.ps *.pdf *.log *.aux *.out *.dvi *.bbl *.blg *.aux *.lot *.lof *.toc *.xdy *.gls *.glo *.glg *.acn *.idx *.ist
bib:
	bibtex ${filename} > report_debug.txt 2>&1

glossaries:
	makeglossaries ${filename} > report_debug.txt 2>&1
