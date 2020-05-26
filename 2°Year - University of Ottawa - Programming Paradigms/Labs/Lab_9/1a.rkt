#lang scheme
(define (square x) (* x x))
(define my_list (list 1 2 3 4))
(define my_list_squared (map square my_list))
(define my_list_squared_summed (foldr + 0 my_list_squared))
my_list_squared_summed