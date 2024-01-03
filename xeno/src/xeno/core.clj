;;xeno/src/core.clj
;;20240102Z
;;jpt4
;;xenotation transliteration in core.logic

(ns xeno.core
  (:require [clojure.core.logic :as lgc
             :refer :all :rename {== ==o}]
            [clojure.core.logic.fd :as fd]
            :reload-all))

;;rangeo-aux - list of natural numbers [s, e]
(defn rangeo-aux [l u s e ls]
  (fresh [m]
    (fd/in s e m (fd/interval l u))
    (conde
     [(fd/== e s) (==o `(~e) ls)]
     [(fd/> e s) (fresh [res]
                   (fd/- e 1 m)
                   (rangeo-aux l u s m res)
                   (appendo res `(~e) ls))])
))

;;rangeo - list of natural numbers [s, e)
(defn rangeo [l u s e ls]
  (fresh [m]
    (fd/in s e m (fd/interval l u))
    (conde
     [(fd/<= e s) (==o '() ls)]
     [(fd/> e s) (fd/- e 1 m)
      (rangeo-aux l u s m ls)]
     )))

;;ioto-aux - list of natural numbers [0, n]
#_(defn ioto-aux [l u n ns]
  (fresh [m]
    (fd/in n m (fd/interval l u)) 
    (conde
     [(fd/== n 0) (==o ns '(0))]
     [(fd/> n 0) (fresh [res]
                   (fd/- n 1 m)
                   (ioto-aux l u m res)
                   (appendo res `(~n) ns))])))

;;ioto - list of natural numbers [0, n)
(defn ioto [l u n ns] (rangeo l u 0 n ns))

#_(defn ioto [l u n ns]
  (fresh [m]
    (fd/in n m (fd/interval l u))
    (conde
     [(fd/<= n 0) (==o '() ns)]
     [(fd/!= n 0)  (fd/- n 1 m)
      (ioto-aux l u m ns)]
     )))
  
;;Sieve of Erathosthenes - produce primes from 2 to n.
(defn soeo [l u n ps]
""
(fresh [nats]
  (fd/in n (fd/interval l u))
  (conde
   [
)
;0. generate list of nats [2, n)
;1. if list not empty, select first element k, collect as prime
;2. remove all multiples of k from list
;3. GOTO 1
;4. if list empty, return collected primes


)  

(defn xeno [a x n]
  ""
  )

(defn foo
  "I don't do a whole lot."
  [x]
  (println x "Hello, World!"))


#_(
Higher order mK
Let us consider a fully general relational map procedure, mapo. 
       Where (map f ls) is function that returns a list of results f(lsk) for k in ls, 
       (mapo r lsi lso) is a higher order relation, that unifies (r
       lsik lsok) for each k in lsi and lso.  Absent a concrete value
       for r, mapo returns candidate relations. This requires a Turing
       Complete program search for the relation r, and indeed an
       infinite number of relations r can be trivially
       generated. However, even given a concrete r it is not clear how
       to do this in object level mK. Instead, given an r, a set of k
       mK clauses must be generated at macro time as (r lsi lso), for
       |lsi|=|lsk|=k. A variable r would require another stage of the
       mK runtime, to allow for program search to generate more
       entries in the list of sets of this type.
 )
