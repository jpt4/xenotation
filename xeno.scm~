;;xeno.scm
;;20181030Z
;;jpt4
;;xenotation transliterator

; :::::: -> '(::::::) : -> '(:) (:) -> '((:))

#|
(define (xgrp? g)
  (cond
   [(equal? ': g) #t]
   [(equal (car g
|#

(define (separate-tics tic-symbol)
  (map (lambda (a) 
	 (string->symbol (list->string (list a)))) 
       (string->list (symbol->string tic-symbol))))

(define primes '(2 3 5 7 11 13 17 19 23 29 31 37 41))

(define new-primes 
  (append primes
	  (cdr
	   (fold-right 
	    (lambda (seive sand) 
	      (filter (lambda (a) (not (zero? (modulo a seive)))) 
		      sand)) 
	    (iota (+ (expt (car (reverse primes)) 2) 1)) primes))))

(define (look-up-index i) (list-ref new-primes (- i 1)))

; ::(:) -> '(: : (:))
(define (x->a x)
  (cond
   [(null? x) 1]
   [(equal? (car x) ':) (* 2 (x->a (cdr x)))]
   [(null? (cdr x)) (look-up-index (x->a (car x)))]
   [(not (null? (cdr x))) (* (x->a (list (car x))) (x->a (cdr x)))]
   ))

;integers from n to m inclusive
(define (range n m)
  (list-tail (iota (+ m 1)) n))

;generate primes <= n
(define (generate-primes n)
  (let loop ([ind 2]
	     [pls '(2)]
	     [seive-max (expt (car pls) 2)])
    (if (<= ind n)
	(fold-right 
	 (lambda (seive sand) 
	   (filter (lambda (a) (not (zero? (modulo a seive)))) 
		   sand)) 
	 (reverse (range a b)) pls)
)))
