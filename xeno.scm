;;xeno.scm
;;20181030Z
;;jpt4
;;xenotation transliterator

; :::::: -> '(::::::) : -> '(:) (:) -> '((:))

(define (separate-tics tic-symbol)
  (map (lambda (a) 
	 (string->symbol (list->string (list a)))) 
       (string->list (symbol->string tic-symbol))))

;sieve of eratosthenes
;primes [2, n]
(define (eratosthenes n)
  (let ([num-vec (list->vector (iota (+ 1 n)))])
    (let inc-loop ([inc 2])
      (if (> inc (floor (sqrt n)))
	  ;return
	  (let ([primes '()])
	    (vector-for-each (lambda (a) (if (not (equal? 'c a))
					     (set! primes (cons a primes))))
			     num-vec)
	    (cddr (reverse primes)))			   
	  (let ind-loop ([ind (+ inc inc)])
	    (cond
	     [(> ind n) (inc-loop (+ 1 inc))]
	     [(vector-set! num-vec ind 'c) (ind-loop (+ ind inc))])
	    )))
    ))

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

(define (prime-index i)
  (if (> i (length new-primes))
      (set! new-primes 
	(generate-primes 
	 (expt (list-ref new-primes (- (length new-primes) 1)) 2)))
      (list-ref new-primes (- i 1))))

(define primes-list (eratosthenes 1000))

;last element of a list
(define (last-element ls) (car (last-pair ls)))

(define (square n) (expt n 2))

(define (prime-index1 i)
  (if (> i (length primes-list))
      (begin
      (set! primes-list
	(eratosthenes (square (last-element primes-list))))
      (list-ref primes-list (- i 1)))
      (list-ref primes-list (- i 1))))

; ::(:) -> '(: : (:))
(define (x->a x)
  (cond
   [(null? x) 1]
   [(equal? (car x) ':) (* 2 (x->a (cdr x)))]
   [(null? (cdr x)) (prime-index (x->a (car x)))]
   [(not (null? (cdr x))) (* (x->a (list (car x))) (x->a (cdr x)))]
   ))

(define (x->a1 x)
  (cond
   [(null? x) 1]
   [(equal? (car x) ':) (* 2 (x->a1 (cdr x)))]
   [(null? (cdr x)) (prime-index1 (x->a1 (car x)))]
   [(not (null? (cdr x))) (* (x->a1 (list (car x))) (x->a1 (cdr x)))]
   ))

;integers from n to m inclusive
(define (range n m)
  (list-tail (iota (+ m 1)) n))

;generate primes <= n
(define (generate-primes-unto-limit n . p)
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
  


(define (eratosthenes-old n)
  (let ([num-vec (list->vector (iota (+ 1 n)))])
    (let inc-loop ([inc 2])
      (if (> inc (floor (sqrt n)))
	  (vector->list num-vec)
	  (let ind-loop ([ind (+ inc inc)])
	    (cond
	     [(> ind n) (inc-loop (+ 1 inc))]
	     [(vector-set! num-vec ind 'c) (ind-loop (+ ind inc))])
	    )))
    (filter (lambda (a) (not (equal? 'c a))) (cddr (vector->list num-vec)))))

;vectorize eratosthenes
(define (eratosthenes-vec1 n)
  (let ([num-vec (list->vector (iota (+ 1 n)))])
    (let inc-loop ([inc 2])
      (if (> inc (floor (sqrt n)))
	  ;return
	  (filter (lambda (a) (not (equal? 'c a))) (cddr (vector->list num-vec)))
	  (let ind-loop ([ind (+ inc inc)])
	    (cond
	     [(> ind n) (inc-loop (+ 1 inc))]
	     [(vector-set! num-vec ind 'c) (ind-loop (+ ind inc))])
	    )))
    ))

(define (eratosthenes-vec2 n)
  (let ([num-vec (list->vector (iota (+ 1 n)))])
    (let inc-loop ([inc 2])
      (if (> inc (floor (sqrt n)))
	  ;return
	  (let ([primes '()])
	    (vector-for-each (lambda (a) (if (not (equal? 'c a))
					     (set! primes (cons a primes))))
			     num-vec)
	    (cddr (reverse primes)))			   
	  (let ind-loop ([ind (+ inc inc)])
	    (cond
	     [(> ind n) (inc-loop (+ 1 inc))]
	     [(vector-set! num-vec ind 'c) (ind-loop (+ ind inc))])
	    )))
    ))

;tests
(define (tster m)
  (car (time (eratosthenes m))))
(define (tste1 n)
  (car (time (eratosthenes-vec1 n))))
(define (tste2 n)
  (car (time (eratosthenes-vec2 n))))	       
(define (tstgp n . p)
  (car (time (generate-primes-unto-limit n p))))

(define (prime-proc-tests n)
  (begin
    (display (tster n))
    (newline)
    (display (tste1 n))
    (newline)
    (display (tste2 n))
    (newline)
    (display (tstgp n 2))
    (newline)))

