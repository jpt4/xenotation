;;xeno.scm
;;20181030Z
;;jpt4
;;xenotation transliterator

; :::::: -> '(::::::) : -> '(:) (:) -> '((:))

;symbol -> list
(define (separate-tics tic-symbol)
  (map (lambda (a) 
	 (string->symbol (list->string (list a)))) 
       (string->list (symbol->string tic-symbol))))

;string -> list
(define (separate-tics1 tic-sym)
  (map (lambda (a) 
	 (if (not (equal? ': a))
	     (symbol->string (string->symbol (list->string (list a))))
	     a))
       (string->list tic-sym)))

(define (separate-tics* ts)
  (cond
   [(null? ts) '()]
   [(symbol? ts) (separate-tics ts)]
   [(symbol? (car ts)) (cons (separate-tics* (car ts)) (separate-tics* (cdr ts)))]
   [(pair? (car ts)) (cons (cons (separate-tics* (caar ts)) (separate-tics* (cdar ts)))
			   (separate-tics* (cdr ts)))]
   ))

(define (sep xst)
  (let ([x (string-zip (string-append (string-append "(" xst) ")") " ")])
    (with-input-from-string x
      (lambda ()
	(let ([p (read)])
	  p)))))

(define (string-zip sa sb)
  (let loop ([ind 0] [acc ""])
    (if (>= ind (string-length sa))
	acc
	(loop (+ 1 ind) 
	      (string-append 
	       acc
	       (string-append (list->string (list (string-ref sa ind))) sb)
	       )))))

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
    ))

(define primes-list (eratosthenes 1000))

;last element of a list
(define (last-element ls) (car (last-pair ls)))

(define (square n) (expt n 2))

;primes are 1-indexed
(define (prime-index i)
  (if (> i (length primes-list))
      (begin
	(extend-primes-list (* (last-element primes-list) 2))
	(prime-index i))
      (list-ref primes-list (- i 1))))

(define (extend-primes-list new-max)
  (if (> new-max (last-element primes-list))
      (set! primes-list
	(eratosthenes new-max))))  

; ::(:) -> '(: : (:))
(define (x->a xexp)
  (cond
   [(null? xexp) 1]
   [(equal? (car xexp) ':) (* 2 (x->a (cdr xexp)))]
   [(null? (cdr xexp)) (prime-index (x->a (car xexp)))]
   [(not (null? (cdr xexp))) (* (x->a (list (car xexp))) (x->a (cdr xexp)))]
   ))

(define (xeno->arabic xst) (x->a (sep xst)))

(define (arabic->xeno num)
  (let ([pls (prime-factors num)])
    '()))

(define (prime-factors num)
  (let loop ([n num] [pind 1] [fls '()])
    (let* ([div (prime-index pind)] 
	   [quo (/ n div)])
      (cond
       [(> div (floor (sqrt n))) (reverse (cons n fls))]
       [(one? quo) (reverse (cons n fls))]
       [(and (integer? quo) (not (one? quo)))
	(loop quo pind (cons div fls))]
       [else (loop n (+ 1 pind) fls)]))))

;integers from n to m inclusive
(define (range n m)
  (list-tail (iota (+ m 1)) n))

(define (zeros n) (make-vector n))

(define (one? n) (equal? 1 n))

;tests
(define (aktst) 
  (equal? (x->a '((: : : : : : : ((:)) (: : :) (((: :))))))
	  (xeno->arabic "(:::::::((:))(:::)(((::))))")))



#|

(separate-tics (string->symbol ":::(((:)::)(::))"))
(: : : \x28; \x28; \x28; : \x29; : : \x29; \x28; : : \x29;
   \x29;)

(map (lambda (a) (if (not (equal? ': a)) (symbol->string a) a)) (separate-tics (string->symbol ":::(((:)::)(::))")))
(: : : "(" "(" "(" : ")" : : ")" "(" : : ")" ")")

|#
#|
(define (sanitize-input xstr)
  (let ([xlst (separate-tics1 xstr)])
    (fold-right (lambda (a kont) 
		  (cond
		   [(equal? ': a) (cons a kont)]
		   [(equal? "(" a) (cons kont ]
		   '()
		   xlst
    
(let loop ([x xlst])
  [(null? x) '()]
  [(equal? (car x) ':) (cons (car x) (loop (cdr x)))]
  [(equal? (car x) "(") (cons (cons 

]

(with-input-from-string ":::::(:):" 
  (lambda () 
    (let loop ([x (separate (read)] [acc '()]) 
      (cond 
       [(
|#


