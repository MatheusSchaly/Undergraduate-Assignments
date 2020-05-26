#lang scheme

; Finds the index of element e in the list L
(define (index e L)
  (let [(tail (member e (reverse L)))]
    (and tail (length (cdr tail)))))

; Replace a value in a list
(define (list-replace lst idx val)
  (if (null? lst)
      lst
      (cons
       (if (zero? idx)
           val
           (car lst))
       (list-replace (cdr lst) (- idx 1) val))))

; Initiate all the countries to 0 points, that is ((peru 0) (greece 0) (vietnam 0))
(define (get_ini_countries_points countries countries_points)
  (if [null? countries]
      '()
      (cons (cons (car countries) '(0)) (get_ini_countries_points (cdr countries) countries_points))
      )
  )

; Get the previous points of the country
(define (get_previous_points country new_ini_countries_points)
  (cond
    [(equal? country (caar new_ini_countries_points))
     (cadar new_ini_countries_points)]
    [else
     (get_previous_points country (cdr new_ini_countries_points))]
    )
  )

; Get the highest calculated point of the countries
(define (get_highest_point new_calculated_countries highest_point)
  (cond
    [(null? new_calculated_countries)
     highest_point]
    [else
     (cond
       [(> (cadar new_calculated_countries) highest_point)
        (get_highest_point (cdr new_calculated_countries) (cadar new_calculated_countries))]
       [else
        (get_highest_point (cdr new_calculated_countries) highest_point)]
       )
     ]
    )
  )

; Get the countries with the highest points
(define (get_most_voted new_calculated_countries highest_point)
  (cond
    [(null? new_calculated_countries)
     '()]
    [else
     (cond
       [(= (cadar new_calculated_countries) highest_point)
        (cons (car new_calculated_countries) (get_most_voted (cdr new_calculated_countries) highest_point))]
       [else
        (get_most_voted (cdr new_calculated_countries) highest_point)]
       )
     ]
    )
  )
     

; Calculates countries points
(define (calc_all_points new_choices)
  (define (calc_person_points personal_countries points)
    (cond
      [(null? personal_countries)
       '()]
      [else
       (define previous_points (get_previous_points (car personal_countries) ini_countries_points)) ; Get the previous points of the country
       (define new_country_points (cons (car personal_countries) (list (+ previous_points points)))) ; Sum up the previous points with the current points
       (define country_index (index (car personal_countries) countries)) ; Get the index of the country
       (set! ini_countries_points (list-replace ini_countries_points country_index new_country_points)) ; Get the country and changes the points of it
       (calc_person_points (cdr personal_countries) (- points 1))]
        )
    )
  
  (cond
    [(null? new_choices)
     ini_countries_points]
    [else
     (calc_person_points (cadar new_choices) (length countries))
     (calc_all_points (cdr new_choices))]
    )
  )


;(define choices  '(("marie" ("peru" "greece" "vietnam"))
;                   ("jean" ("greece" "peru" "vietnam"))
;                   ("sasha" ("vietnam" "peru" "greece"))
;                   ("helena" ("peru" "vietnam" "greece"))
;                   ("emma" ("greece" "peru" "vietnam"))))

(define choices '(("marie" ("peru" "greece" "vietnam"))
                  ("jean" ("greece" "peru" "vietnam"))
                  ("sasha" ("vietnam" "peru" "greece"))
                  ("helena" ("peru" "vietnam" "greece"))
                  ("emma" ("greece" "peru" "vietnam"))
                  ("jane" ("greece" "vietnam" "peru"))))



(define countries (cadar choices))
(define ini_countries_points (get_ini_countries_points countries '()))
(define calculated_countries (calc_all_points choices))
(define highest_point (get_highest_point calculated_countries 0))
(define most_voted (get_most_voted calculated_countries highest_point))

most_voted

