#lang scheme

(define L '(1 2 3 4 5))
(car L)
(cdr L)

(cadr L)
(caddr L)
(cadddr L)
(car (cddddr L))

(define LL '(1 (2 3 4) (5)))
(car (cadr LL))
(caaddr LL)