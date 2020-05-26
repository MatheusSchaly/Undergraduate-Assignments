#lang scheme

(define (drop L k)
  (drop_helper L k 1)
)

(define (drop_helper L k i)
  (cond
    ((null? L) '())
    ((= 0 (remainder i k)) (drop_helper (cdr L) k (+ i 1)))
    (else (cons (car L) (drop_helper (cdr L) k (+ i 1))))
  )
)

(drop '(a b c d e f g) 3)