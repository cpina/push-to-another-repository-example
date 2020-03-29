#!/bin/sh

mkdir output

pandoc -s main.md -o output/main.html
pandoc -s main.md -o output/main.pdf
pandoc -s main.md -o output/main.epub
pandoc -s main.md -o output/main.odt
pandoc -s main.md -o output/main.docx


