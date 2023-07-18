#lang racket
(require racket/trace)
; Exercise 1.18:
;
; Using the results of exercises 1.16 and 1.17, devise a procedure that
; generates an iterative process for multiplying two integers in terms
; of adding, doubling, and halving and uses a logarithmic number of
; steps.

;;; --------------------------ANSWER:--------------------------------


; I actually arrived to this solution in the previous exercise(1.17), so I will just paste the same code here:

(define (even? n) (= (remainder n 2) 0))
(define (double x) (+ x x))
(define (halve x) (/ x 2))

(define (* a b)
    (define (iter a b product)
        (cond ((= b 0) product)
              ((even? b) (iter (double a) (halve b) product))
              (else (iter a (- b 1) (+ a product)))))
    (trace iter)
    (iter a b 0))


(trace *)
(* 10 10)
