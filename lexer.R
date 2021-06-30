# lexer.R
# Define a tokenizer for the REDCap equation syntax.
#
# Copyright (c) 2021, Michael Pascale.

library(R6)
library(rly)

lexer  <- rly::lex(R6Class("Lexer",
  public = list(
    tokens = TOKENS,
    t_LTEQ = '<=',
    t_GTEQ = '>=',
    t_NEQ  = '<>',
    literals = LITERALS,
    t_STRING = function(re='"(.*?)"|\'(.*?)\'', t) {
      t$value <- as.character(gsub('\'|\"', '', t$value))
      return(t)
    },
    t_FUNCTION = '(if|datediff|round|roundup|rounddown|sqrt|exp|abs|min|max|mean|median|sum|stdev|log|isnumber|isinteger|contains|not_contain|starts_with|ends_with|isblankormissingcode)',
    t_NAME = '[a-zA-Z_][a-zA-Z0-9_]*',
    t_NUMBER = function(re='\\d+(\\.\\d+)?', t) {
      t$value <- as.numeric(t$value)
      return(t)
    },
    t_ignore = IGNORE,
    t_newline = function(re='\\n+', t) {
      t$lexer$lineno <- t$lexer$lineno + nchar(t$value)
      return(NULL)
    },
    t_error = function(t) {
      cat(sprintf("Illegal character '%s'\n", t$value[1]))
      t$lexer$skip(1)
      return(t)
    }
  )
))