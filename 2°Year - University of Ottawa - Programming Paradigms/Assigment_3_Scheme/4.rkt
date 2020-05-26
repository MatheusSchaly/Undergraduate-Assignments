#lang scheme

(define e 2.718281828459045235360287471352); Euler number
(define offset_neuron 1) ; The offset neuron

(define (sigmoid v)
  (/ 1 (+ 1 (expt e (- 0 v))))
  )

; a)
(define (neuralNode W f)

  (define sum 0) ; Final sum to be then applied to the function (sigmoid in this case)
  (define offset_input (* offset_neuron (car W))) ; Calculates the input that don't have weight

  ; Computes a single neuron
  (define (neural_computation I)
    (cond
      [(null? I)
       (f (+ offset_input sum))]
      [else
       (set! W (cdr W))
       (set! sum (+ sum (* (car W) (car I))))
       (neural_computation (cdr I))
       ]
      )
    )

  neural_computation
  
  )

; b)
(define (neuralLayer A)

  (define layer_computed '())

  ; Computer all the neurons of a layer
  (define (layer_computation I)
    (cond
      [(null? A)
       layer_computed]
      [else
       (define rested_node (neuralNode (car A) sigmoid)) ; Node without input
       (define inputed_node (rested_node I)) ; Note computed with input
       (set! A (cdr A))
       (set! layer_computed (append layer_computed (list inputed_node)))
       (layer_computation I)]
      )
    )
    
    layer_computation
  
  )

; c)
; Computer all the neural network once
(define (neuralNet I)
  (define z_layer ((neuralLayer '((0.1 0.3 0.4)(0.5 0.8 0.3)(0.7 0.6 0.6))) I ))
  ((neuralNode '(0.5 0.3 0.7 0.1) sigmoid) z_layer)
  )

; d)
; Input functions
(define (get_X k N f)
  (f (/ (* 2 (* pi (- k 1))) N))
  )

; Get the final outputs of the neural network given N and inputs Xs
(define (loop_neural_network N Xs)
  (cond
    [(zero? N)
     '()]
    [else
     (cons (neuralNet (car Xs)) (loop_neural_network (- N 1) (cdr Xs)))]
    )
  )

; Appends list L1 and L2
(define (append-list L1 L2)
  (if (null? L1)
      L2
      (cons (car L1) (append-list (cdr L1) L2))))

; Inverts the list L
(define (invert-list L)
  (if (null? L)
      '()
      (append-list (invert-list (cdr L))
                   (list (car L)))
      )
  )

(define (applyNet N)
  
  (define Xs '())
  (define X1 0)
  (define X2 0)

  ; Calculate the inputs
  (define (loop_get_Xs k) 
    (cond
      [(zero? k)
       0]
      [else
       (set! X1 (get_X k N sin)) ; Input 1
       (set! X2 (get_X k N cos)) ; Input 2
       (set! Xs (append Xs (list (cons X1 (list X2))))) ; Input 1 and 2
       (loop_get_Xs (- k 1))]
      )
    )
       
  (loop_get_Xs N)
  (define inverted_outputs (loop_neural_network N Xs))
  (invert-list inverted_outputs)

  )

; Uncomment if you want to check the steps
;(neuralNode '(0.1 0.3 0.4) sigmoid)
;((neuralNode '(0.1 0.3 0.4) sigmoid) '(0.5 0.5))
;(neuralLayer '((0.1 0.3 0.4)(0.5 0.8 0.3)(0.7 0.6 0.6)))
;((neuralLayer '((0.1 0.3 0.4)(0.5 0.8 0.3)(0.7 0.6 0.6))) '(0.5 0.5))
;(neuralNet '(0.5 0.5))

(applyNet 16)