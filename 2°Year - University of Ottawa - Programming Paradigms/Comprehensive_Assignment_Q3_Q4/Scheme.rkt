#lang racket

; Load from csv
(require (planet neil/csv:1:=7) net/url)

(define make-reader
  (make-csv-reader-maker
   '((separator-chars              #\,)
     (strip-leading-whitespace?  . #f)
     (strip-trailing-whitespace? . #f))))
 
(define (all-rows port)
  (define read-row (make-reader port))
  (define head (append (read-row) '("SUM")))
  (define rows (for/list ([row (in-producer read-row '())])
                 (define xs (map string->number row))
                 (append row (list (~a (apply + xs))))))
  (define (->string row) (string-join row "," #:after-last "\n"))
  (string-append* (map ->string (cons head rows))))


(define (get_list_from_file L next-row)
  (define New_L (next-row))
  (cond
   [(null? New_L)
    '()]
   [(equal? (car New_L) "")
    '()]
   [else
    (cons New_L (get_list_from_file L next-row))]
   )
  )

; Write to csv
(define (write_to_file l path)
  (call-with-output-file path
    (lambda (output_port)
      (write l output_port))
    #:exists 'replace
    #:mode 'binary))


; Start
(define (findStableMatch Es_file Ss_file)
  (define next_row_e (make-reader (open-input-file Es_file)))
  (define Es (get_list_from_file '() next_row_e)) ; Get Employers list
  (define next_row_s (make-reader (open-input-file Ss_file)))
  (define Ss (get_list_from_file '() next_row_s)) ; Get Students list
  (stableMatching Es Ss)
  )

; McVitie-Wilson algorithm
(define (stableMatching Es Ss)

  ; Check if employer is matched
  (define (e_matched? e Ms)
    (cond
      [(null? Ms)
       #f]
      [(equal? e (caar Ms))
       #t]
      [else
       (e_matched? e (cdr Ms))]
      )
    )

  ; Check if student is matched
  (define (s_matched? s Ms)
    (cond
      [(null? Ms)
       #f]
      [(equal? s (cdar Ms))
       #t]
      [else
       (s_matched? s (cdr Ms))]
      )
    )

  ; Get student current match
  (define (get_s_match s Ms)
    (cond
      [(equal? s (cdar Ms))
       (caar Ms)]
      [else
       (get_s_match s (cdr Ms))]
      )
    )

  ; Get employer or student preferences
  (define (get_ps e_or_s Es_or_Ss)
    (cond
      [(equal? e_or_s (caar Es_or_Ss))
       (cdar Es_or_Ss)]
      [else
       (get_ps e_or_s (cdr Es_or_Ss))]
      )
    )

  ; Replace a value in a list
  (define (list-replace lst idx val)
    (if (null? lst)
        lst
        (cons
         (if (zero? idx)
             val
             (car lst))
         (list-replace (cdr lst) (- idx 1) val))))

  ; Delete an existing element from a list
  (define (delete element lst)
    (let loop ([temp lst])
        (if (equal? element (car temp)) (cdr temp)
            (cons (car temp) (loop (cdr temp))))))
  
   ; Remove student from Es
  (define (update_Es e new_Es i)
    (cond
      [(equal? e (caar new_Es))
       (set! Es (list-replace Es i (cons (caar new_Es) (cddar new_Es))))]
      [else
       (set! i (+ i 1))
       (update_Es e (cdr new_Es) i)]
      )
    )

  ; Check is student prefers new employer
  (define (s_p_new_e? new_e current_e s_ps)
    (cond
      [(equal? new_e (car s_ps))
       #t]
      [(equal? current_e (car s_ps))
       #f]
      [else
       (s_p_new_e? new_e current_e (cdr s_ps))]
      )
    )
    
  ; Offer function
  (define (offer e)
    (define e_ps (get_ps e Es))
    (when
     [and (not (null? e_ps)) (not (e_matched? e M))]
      (define p_s (car e_ps))
      (update_Es e Es 0)
      (evaluate (cons e (list p_s)))
     )
    )

  ; Evaluate function
  (define (evaluate m)
    (define s_ps (get_ps (cadr m) Ss))
    (cond
      [(not (s_matched? (cdr m) M))
       (set! M (cons m M))]
      [(s_p_new_e? (car m) (get_s_match (cdr m) M) s_ps)
       (define current_e (get_s_match (cdr m) M))
       (set! M (delete (cons current_e (cdr m)) M))
       (set! M (cons m M))
       (offer current_e)]
      [else
       (offer (car m))]
      )
    )

  ; Loops once for each employer
  (define (loop new_Es)
    (cond
      [(null? new_Es)
       M]
      [else
       (offer (caar new_Es))
       (loop (cdr new_Es))]
      )
    )

  ; Matches
  (define M '())

  ; Main loop
  (loop Es)

  )


(define M (findStableMatch "coop_e_3x3.csv" "coop_s_3x3.csv"))
(define size (number->string (length M)))
(define file_name (string-append (string-append "matches_scheme_" (string-append size (string-append "x" size))) ".csv"))
(write_to_file M file_name)