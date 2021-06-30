# parser.R
# Define a parser for the REDCap equation syntax.
#
# Copyright (c) 2021, Michael Pascale.

library(R6)
library(rly)

source('functions.R')

parser <- rly::yacc(R6Class("Parser",
  public = list(
    tokens = TOKENS,
    literals = LITERALS,
    # Parsing rules
    precedence = list(c('left','+','-'),
                      c('left','*','/'),
                      c('right','UMINUS')),
    p_statement_expr = function(doc='statement : expression', p) {
      cat(p$get(2))
      cat('\n')
    },
    # Binary arithmetic operations.
    p_expression_binop = function(doc="expression : expression '+' expression
                                                  | expression '-' expression
                                                  | expression '*' expression
                                                  | expression '/' expression
                                                  | expression '^' expression
                                                  | expression '%' expression
                                                  | expression '=' expression
                                                  | expression '<' expression
                                                  | expression '>' expression
                                                  | expression LTEQ expression
                                                  | expression GTEQ expression
                                                  | expression NEQ expression", p) {
      p$set(1, switch(p$get(3),
        '+'=p$get(2) + p$get(4),
        '-'=p$get(2) - p$get(4),
        '*'=p$get(2) * p$get(4),
        '/'=p$get(2) / p$get(4),
        '^'=p$get(2) ^ p$get(4),
        '%'=p$get(2) %% p$get(4),
        '='=ifelse(p$get(2) == p$get(4), 1, 0),
        '<'=ifelse(p$get(2) < p$get(4), 1, 0),
        '>'=ifelse(p$get(2) > p$get(4), 1, 0),
        '<='=ifelse(p$get(2) <= p$get(4), 1, 0),
        '>='=ifelse(p$get(2) >= p$get(4), 1, 0),
        '<>'=ifelse(p$get(2) != p$get(4), 1, 0)
      ))

    },
    p_function_call = function(doc="function_call : FUNCTION '(' exprlist ')'", p) {
      cat(sprintf('function called: %s\n', p$get(4)))
      p$set(1, do.call(paste0('rc_', p$get(2)), as.list(p$get(4))))
    },
    p_expr_list = function(doc="exprlist : exprlist ',' expression
                                         | expression", p) {
      if (p$length() > 2) {
        p$set(1, c(p$get(2), p$get(4)))
      } else {
        p$set(1, c(p$get(2)))
      }
    },
    p_expression_uminus = function(doc="expression : '-' expression %prec UMINUS", p) {
      p$set(1, -p$get(3))
    },
    p_expression_group = function(doc="expression : '(' expression ')'", p) {
      p$set(1, p$get(3))
    },
    p_expression_string = function(doc="expression : STRING", p) {
      p$set(1, p$get(2))
    },
    p_expression_call = function(doc="expression : function_call", p) {
      p$set(1, p$get(2))
    },
    p_expression_number = function(doc="expression : NUMBER", p) {
      p$set(1, p$get(2))
    },
    p_expression_name = function(doc="expression : '[' NAME ']'", p) {
      p$set(1, RECORDS[[as.character(p$get(3))]])
    },
    p_error = function(p) {
      if(is.null(p)) 
        cat("Syntax error at EOF.\n")
      else
        cat(sprintf("Syntax error at: %s.\n", p$value))
    }
  )
))