tic-xenotation

Transliteration between tic-xenotation [0] and Arabic numerals.

[0] hyperstition.abstractdynamics.org/archives/003538.html

Capabilities:

Transliterate from Arabic to either tic-xenotation numerals and vice-versa

Requirements:

Chez Scheme - https://cisco.github.io/ChezScheme/

Available from most package managers, e.g.

sudo apt install chezscheme

guix package -i chez-scheme

Usage:

$ git clone https://www.github.com/jpt4/tic-xenotation

$ cd tic-xenotation

$ chez-scheme

(load "xeno.scm")

(x->a '(:))

2

(x->a '(: :))

4

(x->a '(: (: :)))

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

(x->a '(: (:)))

6

(:::::::((:))(:::)(((::)))) -> '((: : : : : : : ((:)) (: : :) (((: :))))))

(x->a '((: : : : : : : ((:)) (: : :) (((: :))))))

10852909

Passes the Akira test.