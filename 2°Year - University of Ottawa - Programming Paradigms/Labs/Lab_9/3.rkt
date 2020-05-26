#lang scheme
((lambda (alpha beta) (+ (* (sin alpha) (cos beta)) (+ (cos alpha) (sin beta)))) (/ pi 4) (/ pi 3))
(define foo (lambda (alpha beta) (+ (* (sin alpha) (cos beta)) (+ (cos alpha) (sin beta)))))
(foo (/ pi 4) (/ pi 3))
(foo 1 2)