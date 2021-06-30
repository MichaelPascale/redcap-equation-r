# functions.R
# Implements the 'advanced functions' available in REDCap equations or
# translates to equivalent counterparts in base R.
#
# Copyright (c) 2021, Michael Pascale.

library(lubridate)

rc_if <- function (cond, val_then, val_else) {
    ifelse(cond, val_then, val_else)
}

rc_datediff <- function (date1, date2, units, returnSignedValue=FALSE) {
    warning('rc_datediff not implemented.')
    date1 <- ymd(date1)
    date2 <- ymd(date2)
    diff <- interval(start=date1, end=date2)
    diff <- as.duration(diff)

    # TODO: Implement duration unit conversions.
    diff = switch(
        units,
        'y'=1,
        'M'=1,
        'd'=1,
        'h'=1,
        'm'=1,
        's'=1
    )

    ifelse(returnSignedValue, diff, abs(diff))
}

rc_round <- function (number, decimals=0) {
    warning('rc_round not implemented.')
}

rc_roundup <- function (number, decimals) {
    warning('rc_roundup not implemented.')
}

rc_rounddown <- function (number, decimals) {
    warning('rc_rounddown not implemented.')
}

rc_sqrt <- function (number) {
    sqrt(number)
}

rc_abs <- function (number) {
    abs(number)
}

rc_min <- function (...) {
    min(...)
}

rc_max <- function (...) {
    max(...)
}

rc_mean <- function (...) {
    mean(c(...))
}

rc_median <- function (...) {
    median(c(...))
}

rc_sum <- function (...) {
    sum(...)
}

rc_stdev <- function (...) {
    sd(c(...))
}

rc_log <- function (number, base=exp(1)) {
    log(number, base)
}

rc_isnumber <- function (value) {
    ifelse(is.numeric(value), 1, 0)
}

rc_isinteger <- function (value) {
    ifelse(value%%1, 0, 1)
}

rc_contains <- function (haystack, needle) {
    ifelse(grepl(needle, haystack), 1, 0)
}

rc_not_contain <- function (haystack, needle) {
    ifelse(grepl(needle, haystack), 0, 1)
}

rc_starts_with <- function (haystack, needle) {
    ifelse(startsWith(haystack, needle), 1, 0)
}

rc_ends_with <- function (haystack, needle) {
    ifelse(endsWith(haystack, needle), 1, 0)
}

rc_isblankormissingcode <- function (value) {
    warning('rc_isblankormissingcode not implemented.')
    if (
        value == NA ||
        value == ''#|| value = 'NaN'...
    ) 1 else 0
}