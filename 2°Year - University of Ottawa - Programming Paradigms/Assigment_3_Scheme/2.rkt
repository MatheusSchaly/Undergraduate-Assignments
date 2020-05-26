#lang scheme

; Create sublists. E.g. Get a List (x y y z) and return a List ((x) (y y) (z))
(define (split L IL LS)
  (cond
    ((null? L) ; If list is null, finish the last element and return
     (set! LS (cons IL LS))
     LS)
    ((null? IL) ; If the new sublist is null, simply add the element
     (set! IL (cons (car L) IL))
     (split (cdr L) IL LS))
    (else
     (cond
       ((= (car L) (car IL)) ; If car of L and sublist have same element, add element to sublist
        (set! IL (cons (car L) IL))
        (split (cdr L) IL LS))
       (else ; If they are different, do not add the element, close the sublist, and continue with L
        (set! LS (cons IL LS))
        (set! IL '())
        (split L IL LS)
        )
       )
     )
    )
  )

; Reverse a list
(define (reverse_list L)
  (if (null? L)
     '()
     (append (reverse_list (cdr L)) (list (car L)))
  )
)

; Count the sublists. E.g. Get a List ((x) (y y) (z)) and return the List (1 2 1)
(define (count_splits_length L LC)
  (cond
    ((null? L)
     LC)
    (else (cons (length (car L)) (count_splits_length (cdr L) LC)))
    )
  )

; Find biggest number index. E.g. Get a list (1 2 1) and return 1
(define (biggest_index L i biggest_i biggest_n)
  (set! i (+ i 1))
  (cond
    ((null? L)
     biggest_i)
    (else
     (cond
       ((<= biggest_n (car L))
        (biggest_index (cdr L) i i (car L)))
       (else
        (biggest_index (cdr L) i biggest_i biggest_n))
       )
     )
    )
  )

; Find the longest sub-list of numbers which are identical and return this sub-list.
; In case of a tie, return the sub-list occurring last.
(define (sameNum L)
  (define LR (reverse_list L))
  (define LS (split LR '() '()))
  (define LC (count_splits_length LS '()))
  (define biggest_i (biggest_index LC -1 0 0))
  (list-ref LS biggest_i)
  )

(sameNum '( 0 1 5 3 3 3 2 1 1))
(sameNum '( 0 1 5 3 3 3 2 1 1 1))





