;;xeno.scm
;;20181030Z
;;jpt4
;;xenotation transliterator

; :::::: -> '(::::::) : -> '(:) (:) -> '((:))

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
(define (generate-primes n . p)
  (reverse
   (letrec* 
       ([primels (if (null? p) '(2) (reverse (car p)))]
	[sieve-maximum (expt (car primels) 2)]
	[loop 
	 (lambda (pls sieve-max)
	   (define (loop-aux range-max)
	     (append (fold-right 
		      (lambda (sieve sand) 
			(filter (lambda (a) 
				  (not (zero? (modulo a sieve))))
				sand)) 
		      (reverse (range (car pls) range-max)) pls)
		     pls))
	   (cond
	    [(<= sieve-max n)
	     (let ([newpls
		    (loop-aux sieve-max)])
	       (loop newpls (expt (car newpls) 2)))]
	    [(and (<= (car pls) n) (< n sieve-max))     
	     (loop-aux n)]
	    [(< xn (car pls))
	     (remp (lambda (a) (> a n)) pls)]
	    ))])
     (loop primels sieve-maximum))))
  
