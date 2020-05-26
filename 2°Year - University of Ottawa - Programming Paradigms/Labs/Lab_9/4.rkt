#lang scheme
(define foo (lambda (a b c)
              (list (/ (+ (- b) (sqrt (- (* b b) (* 4 a c)))) (* 2 a))
                    (/ (- (- b) (sqrt (- (* b b) (* 4 a c)))) (* 2 a)))))
(foo 2 5 -3)