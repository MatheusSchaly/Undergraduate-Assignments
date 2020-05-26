#lang scheme

; 3x3 example table
(define t3
  '(((0 0) (2 1) (0 0))
    ((0 0) (0 1) (0 0))
    ((0 0) (0 0) (3 0))))

; 4x4 example table
(define t4
  '(((0 0) (4 1) (1 0) (0 0))
    ((0 1) (0 0) (0 0) (0 0))
    ((0 0) (1 0) (0 1) (0 0))
    ((0 0) (0 0) (0 1) (0 0))))

; 5x5 example table 1
(define t5_1
  '(((0 0) (3 0) (0 1) (0 0) (2 1))
    ((3 0) (0 0) (0 0) (0 0) (5 0))
    ((0 0) (0 1) (0 0) (2 1) (0 0))
    ((1 1) (0 0) (4 0) (0 1) (0 0))
    ((0 1) (0 0) (0 0) (0 0) (0 1))))

; 5x5 example table 2
(define t5_2
  '(((4 0) (0 0) (3 0) (0 0) (5 1))
    ((0 1) (0 0) (0 0) (0 0) (1 0))
    ((0 1) (0 1) (5 1) (0 1) (0 1))
    ((0 1) (0 0) (0 0) (4 0) (0 0))
    ((1 1) (0 0) (0 1) (0 0) (0 1))))

; 6x6 example table
(define t6
  '(((0 1) (0 0) (0 0) (1 1) (0 1) (0 1))
    ((0 1) (0 0) (0 0) (0 0) (5 0) (0 0))
    ((0 1) (0 0) (1 0) (0 0) (0 0) (0 0))
    ((4 0) (0 0) (0 0) (0 0) (0 0) (0 1))
    ((0 0) (6 0) (5 0) (0 0) (0 0) (0 1))
    ((0 1) (0 1) (0 1) (0 0) (1 0) (4 1))))

; 9x9 example table
(define t9
  '(((0 1) (0 1) (0 0) (5 0) (0 1) (1 0) (0 0) (3 1) (0 1))
    ((0 0) (9 0) (0 0) (3 0) (0 0) (2 0) (0 0) (0 0) (0 0))
    ((7 0) (0 0) (1 1) (0 0) (0 0) (0 0) (0 1) (0 0) (5 0))
    ((5 0) (0 1) (0 1) (4 0) (0 0) (0 1) (0 0) (8 0) (6 1))
    ((0 1) (0 0) (0 0) (0 0) (0 0) (0 0) (0 0) (0 0) (0 1))
    ((8 1) (0 0) (4 0) (0 1) (0 0) (0 0) (0 1) (0 1) (0 0))
    ((0 0) (1 0) (0 1) (0 0) (0 0) (0 0) (5 1) (4 0) (0 0))
    ((0 0) (0 0) (0 0) (0 0) (0 0) (0 0) (0 0) (0 0) (0 0))
    ((0 1) (7 1) (0 0) (9 0) (0 1) (5 0) (6 0) (0 1) (0 1))))

; Defines the table to use
; Use second paramter to change the table
(define t t9)

; Sets an element in a row
(define (set-row r c e)
  (cond
    [(= c 0)
     (cons e (cdr r))]
    [else
     (cons (car r) (set-row (cdr r) (- c 1) e))]))

; Sets an element in a table
(define (set-table table r c e)
  (cond
    [(= r 0)
     (cons (set-row (car table) c e) (cdr table))]
    [else
     (cons (car table) (set-table (cdr table) (- r 1) c e))]))

; Gets a tuple from a table
(define (get-tuple ri ci)
  (let [(r (get-row t ri))]
    (list-ref r ci)))

; Get a row from a table
(define (get-row r n)
  (cond
    [(= n 0)
     (car r)]
    [else
     (get-row (cdr r) (- n 1))]))

; Get a column from a table
(define (get-col table n)
  (let loop [(i (length table)) (result '())]
    (cond
      [(= i 0)
       result]
      [else
       (loop (- i 1) (cons (get-row (get-row table (- i 1)) n) result))])))

; Mathematics set difference 
(define (set-difference s1 s2)
  (cond
    [(null? s1)
     '()]
    [(not (member (car s1) s2))
     (cons (car s1) (set-difference (cdr s1) s2))]
    [else
     (set-difference (cdr s1) s2)]))

; Mathematics set intersection
(define (intersection s1 s2)
  (cond
    [(null? s1)
     '()]
    [else
     (cond
       [(member (car s1) s2)
        (cons (car s1) (intersection (cdr s1) s2))]
       [else
        (intersection (cdr s1) s2)])]))

; Mathematics set union
(define (union s1 s2)
  (cond
    [(null? s2)
     s1]
    [(member (car s2) s1)
     (union s1 (cdr s2))]
    [else
     (union (cons (car s2) s1) (cdr s2))]))

; Creates a range from l to h
(define (range l h)
  (cond
    [(= l h)
     (list l)]
    [else
     (cons l (range ((cond
                       [(< l h)
                        +]
                       [else
                        -])
                       l 1) h))]))

; Gets the first elements from a list of tuples, removing the 0 values
(define (get-list-values rc)
  (cond
    [(null? rc)
     '()]
    [(= (caar rc) 0)
     (get-list-values (cdr rc))]
    [else
     (cons (caar rc) (get-list-values (cdr rc)))]))

; Gets list of value which is set difference of the row/column values and all possible values
(define (get-list-poss rc)
  (let ([list-values (get-list-values rc)])
    (set-difference all-poss list-values)))

; Gets all the previous values until finding a black cell or the end of the table
(define (get-prev rc i)
  (cond
    [(= i -1)
     '()]
    [(= 1 (cadr (list-ref rc i)))
     '()]
    [else
     (cons (car (list-ref rc i)) (get-prev rc (- i 1)))]))

; Gets all the following values until finding a black cell or the end of the table
(define (get-next rc i)
  (cond
    [(= i (length all-poss))
     '()]
    [(= 1 (cadr (list-ref rc i)))
     '()]
    [else
     (cons (car (list-ref rc i)) (get-next rc (+ i 1)))]))

; Removes all the zeros from a list
(define (remove-zeros l)
  (cond
    [(null? l)
     '()]
    [(= 0 (car l))
     (remove-zeros (cdr l))]
    [else
     (cons (car l) (remove-zeros (cdr l)))]))

; Gets the max (>) or min (<) of list l depending on function f
(define (get-max-min l f)
  (cond
    [(null? (cdr l))
     (car l)]
    [else
     (cond
       [(f (car l) (get-max-min (cdr l) f))
        (car l)]
       [else
        (get-max-min (cdr l) f)])]))

; Uses the formula max - N + 1 to get the lower bound of possibilities
(define (get-min-seq max N)
  (cond
    [(< (+ (- max N) 1) 1)
     1]
    [else
     (+ (- max N) 1)]))

; Uses the formula min + N - 1 to get the upper bound of possibilities
(define (get-max-seq min N)
  (cond
    [(> (- (+ min N) 1) (length all-poss))
     (length all-poss)]
    [else
     (- (+ min N) 1)]))

; Gets the possibilities of a white strip
(define (get-sequence strip)
  (let* [(max (get-max-min (car strip) >))
         (min (get-max-min (car strip) <))
         (min-seq (get-min-seq max (cdr strip)))
         (max-seq (get-max-seq min (cdr strip)))
         (poss (range min-seq max-seq))]
    poss))

; Finds a white strip
(define (get-strip rc i)
  (let* [(prev (get-prev rc (- i 1)))
         (next (get-next rc (+ i 1)))
         (strip-length (+ (+ (length prev) (length next)) 1))
         (union-list (union prev next))]
    (cond
      [(= 0 (length (remove-zeros union-list)))
       (cons all-poss (length all-poss))]
      [else
       (let [(union-list-no-zero (remove-zeros union-list))]
         (cons union-list-no-zero strip-length))])))

; Finds a white strip and gets its possibilities
(define (get-strip-poss rc i)
  (let [(strip (get-strip rc i))]
    (cond
      [(null? (car strip)) ; Useless check
       '()]
      [else
       (get-sequence strip)])))

; Gets all the possibilities that can be inserted into position row index (ri) and row column (rc)
(define (get-poss ri ci)
  (let* [(r (get-row t ri))
         (row-poss (get-list-poss r))
         (c (get-col t ci))
         (col-poss (get-list-poss c))
         (itersection-1 (intersection row-poss col-poss))
         (row-strip-poss (get-strip-poss r ci))
         (itersection-2 (intersection row-strip-poss itersection-1))
         (col-strip-poss (get-strip-poss c ri))
         (final_intersection (intersection col-strip-poss itersection-2))]
  final_intersection))

; Loops recursively over each possibility until a solution if found
(define (loop3 x y poss)
  (cond
    [(null? poss)
     #f]
    [else
     (set! t (set-table t x y (list (car poss) 0)))
     (let [(straight_rec (straight))] ; Recursion
       (cond
         [(equal? #t straight_rec)
          #t]
         [else
          (set! t (set-table t x y '(0 0)))
          (let [(looped3 (loop3 x y (cdr poss)))]
            (cond
              [(equal? #t looped3)
               #t]
              [else
               #f]))]))]))

; Loops over each element in a row
(define (loop2 x y)
  (cond
    [(= -1 y)
     #t]
    [else
     (cond
       [(and (= 0 (cadr (get-tuple x y))) (= 0 (car (get-tuple x y))))
        (let [(poss (get-poss x y))]
          (cond
            [(null? poss)
             #f]
            [else
             (let [(looped3 (loop3 x y poss))]
               (cond
                 [(equal? #t looped3)
                  #t]
                 [else
                  #f]))]))]
       [else
        (loop2 x (- y 1))])]))

; Loops over each element row
(define (loop1 x)
  (cond
    [(= -1 x)
     #t]
    [else
     (let [(looped2 (loop2 x (- (length all-poss) 1)))]
       (cond
         [(equal? #f looped2)
          #f]
         [(and (= x 0) (equal? #t looped2))
          #t]
         [else
          (loop1 (- x 1))]))]))

; Finds the solution to the straight puzzle 
(define (straight)
  (let [(looped1 (loop1 (- (length all-poss) 1)))]
    (cond
      [(equal? looped1 #t)
       #t]
      [else
       #f])))

; Defines all possibilities that a element in the table can have
(define all-poss (range 1 (length (get-row t 0))))

; Displays the solution to the straight puzzle
(define (display-matrix n)
  (cond
    [(= n (length all-poss))]
    [else
     (display "\n")
     (display (get-row t n))
     (display-matrix (+ n 1))]))

; Main
(display "\nInput:")
(display-matrix 0)
(straight)
(display "\nSolution:")
(display-matrix 0)