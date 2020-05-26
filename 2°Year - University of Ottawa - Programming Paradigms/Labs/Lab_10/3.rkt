#lang scheme

(define (range i k)
  (cond
    ((> i k) 'range_error)
    (#t (do ((m k (- m 1))
        (L '() (cons m L)))
        ((< m i)
        L)))
  )
)

(range 10 9)
(range 9 9)
(range 8 9)
(range 4 9)