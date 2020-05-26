#lang scheme

(define (addSubList Q)
  (cond
    ((null? Q) '())
    ((list? (car Q)) (cons (foldr + 0 (car Q)) (addSubList (cdr Q))))
    (else (cons (car Q) (addSubList (cdr Q))))
  )
)

(addSubList '(1 2 (3 4) 1 5 (7 8)))