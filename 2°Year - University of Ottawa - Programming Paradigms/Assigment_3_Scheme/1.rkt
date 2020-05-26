#lang scheme

(define (between_ones? x)              ; Tests if x is < -1 or > 1
  (or (< x -1) (> x 1))
)

(define (changeList L)
  (define L1 (filter between_ones? L)) ; Removes -1 and +1 inclusive
  (define L2 (map                      ; Replaces n > 1 to 10x n
              (lambda (x)
                (if (> x 1) (* 10 x) x))
              L1
             )
  )
  (map                                 ; Replaces n < 1 to absolute reciprocal of n
   (lambda (x)
     (let ((y (abs (/ 1 x))))
       (if (< x -1) y x)))
   L2
  )
)

(changeList '(0 -2 3 -4 1))
(changeList '(-4 0.5 -0.5 1 -1 5 2 1 -2 3))
(changeList '())