#lang scheme
(define delta (- (* 5 5) (* 4 2 -3)))
(define root1 (/ (+ -5 (sqrt delta)) (* 2 2)))
root1
(define root2 (/ (- -5 (sqrt delta)) (* 2 2)))
root2
(define root (/ (+ -5 (sqrt (- (* 5 5) (* 4 2 -3)))) (* 2 2)))
