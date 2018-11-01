tic-xenotation

Transliteration between tic-xenotation and Arabic numerals.

Current status: transliterate xeno -> Arabic, not yet the inverse.

Requirements:

Chez Scheme - https://cisco.github.io/ChezScheme/

Available from most package managers, e.g.

sudo apt install chezscheme

guix package -i chez-scheme

Usage:

$ git clone https://www.github.com/jpt4/tic-xenotation
$ cd tic-xenotation
$ chez-scheme
> (load "xeno.scm")
> (x->a '(:))
2
> (x->a '(: :))
4
> (x->a '(: (: :)))
14

Notes: 

A given xenotation expression (xexp) must be wrapped inside of
a quoted list.

Ex. (:) -> '((:))

Additionally, strings of colons must be converted into space separated
symbol lists. 
::::: -> '(: : : : :)

Examples:

:(:) -> '(: (:))

> (x->a '(: (:)))
6

(:::::::((:))(:::)(((::)))) -> '((: : : : : : : ((:)) (: : :) (((: :))))))

> (x->a '((: : : : : : : ((:)) (: : :) (((: :))))))
Exception in list-ref: index 717439 is out of range for list (2 3 5 7 11 13 ...)
Type (debug) to enter the debugger.

[Because the prime list is currently hardcoded, and does not grow
automatically. TODO]