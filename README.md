# Parse and Execute REDCap Equations in R

The aim of this repository is to provide an R implementation of the syntax for equations and calculated fields employed by [REDCap](https://www.project-redcap.org/) such that fields can be recalculated and checked against REDCap from a local R pipeline.

Currently, only basic functionality is achieved; a REPL can be run with `language.R`.

### To-do List:

- [x] implement basic grammar
- [ ] implement REDCap functions
- [ ] implement a standard format for the REDCap dataframe
- [ ] create R package

---

Copyright (c) 2021, Michael Pascale. MIT licensed.

Created with [`rly`](https://cran.r-project.org/web/packages/rly/index.html), an R implementation of `lex` and `yacc`.