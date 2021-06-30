# language.R
# Execute REDCap calculations in R.
#
# Copyright (c) 2021, Michael Pascale.

TOKENS <- c('NAME', 'FUNCTION', 'NUMBER', 'STRING', 'LTEQ', 'GTEQ', 'NEQ')
LITERALS <- c('=','+','-','*','/','^','%',',','<','>','(',')','[',']')
IGNORE <- '\t '

RECORDS <- list(
    'studyid'='POTS_123',
    'age'=32
)

source('lexer.R')
source('parser.R')

while(TRUE) {
    cat('# ')
    s = readLines(file("stdin"), n=1)
    if(s == 'exit') break
    parser$parse(s, lexer)
}