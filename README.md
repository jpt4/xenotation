xenotation

Transliteration between xenotation [0] and Arabic numerals.

[0] hyperstition.abstractdynamics.org/archives/003538.html

Capabilities:

Transliterate from Arabic to tic xenotation numerals and
vice-versa.

Transliterate from Arabic to nullified xenotation and vice-versa.

Requirements:

Chez Scheme - https://cisco.github.io/ChezScheme/

Available from most package managers, e.g.

sudo apt install chezscheme

guix package -i chez-scheme

Usage:

$ git clone https://www.github.com/jpt4/xenotation

$ cd xenotation

$ chez-scheme

(load "xeno.scm")

(xeno->arabic "(:::::::((:))(:::)(((::))))")

10852909

(x->a '((: : : : : : : ((:)) (: : :) (((: :))))))

10852909

Passes the Akira test.

Function Reference:

(xeno->arabic)

Input: Tic-xenotation numeral as string

Output: Arabic numeral as number

Example:

(xeno->arabic ":(:)(::)")

42

(null-xeno->arabic)

Input: Nullified xenotation numeral as string

Output: Arabic numeral as number

Example:

(null-xeno->arabic "()(())(()())")

42

(arabic->xeno)

Input: Arabic numeral as number

Output: Tic xenotation numeral as string

Example:

(arabic->xeno 42)

":(:)(::)"

(arabic->null-xeno)

Input: Arabic numeral as number

Output: Nullified xenotation numeral as string

Example:

(arabic->xeno 42)

"()(())(()())"

(x->a)

Input: Tic xenotation as a xenotation expression, aka xexp

Output: Arabic numeral as a number

Example:

(x->a '(: (:) (: :)))

42

(nx->a)

Input: Tic xenotation as a nullified xenotation expression, aka nxexp

Output: Arabic numeral as a number

Example:

(x->a '(() (()) (() ())))

42

(a->x)

Input: Arabic numeral as a number

Output: Tic xenotation as a xenotation expression, aka xexp

Example:

(a->x 42)

(: (:) (: :)))

(a->nx)

Input: Arabic numeral as a number

Output: Tic xenotation as a nullified xenotation expression, aka nxexp

Example:

(a->nx 42)

(() (()) (() ())))

Notes:

(x->a) and (nx->a) each accept both tic and nullified xenotation.

Numeral transliteration feasibility is proportional to its primality,
not absolute magnitude.

Miscellaneous examples:

(null-xeno->arabic (arabic->null-xeno (nx->a (a->nx (x->a (a->x 42))))))

42


