#lang scheme
(define (halfTrig theta)
  (let* ((lambda1 (tan (/ theta 2)))
         (lambda2 (tan (/ 1.57 2)))
         (lambda3 (* lambda2 lambda2)))
    (/ (* 2 lambda1) 
       (+ 1 lambda3))))