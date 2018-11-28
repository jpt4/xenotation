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

(define (era2 n)
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
    )

(define primes-list (eratosthenes 1000))

;last element of a list
(define (last-element ls) (car (last-pair ls)))

(define (square n) (expt n 2))

(define (prime-index i)
  (if (> i (length primes-list))
      (begin
      (set! primes-list
	(eratosthenes (* (last-element primes-list) 2)))
      (prime-index i))
      (list-ref primes-list (- i 1))))

; ::(:) -> '(: : (:))
(define (x->a x)
  (cond
   [(null? x) 1]
   [(equal? (car x) ':) (* 2 (x->a (cdr x)))]
   [(null? (cdr x)) (prime-index (x->a (car x)))]
   [(not (null? (cdr x))) (* (x->a (list (car x))) (x->a (cdr x)))]
   ))

;integers from n to m inclusive
(define (range n m)
  (list-tail (iota (+ m 1)) n))

;tests
(define (aktst) (x->a1 '((: : : : : : : ((:)) (: : :) (((: :)))))))


