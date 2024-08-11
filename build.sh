# Generated from trgen 0.23.2
set -e
if [ -f transformGrammar.py ]; then python3 transformGrammar.py ; fi
antlr4 -Dlanguage=Cpp *.g4
