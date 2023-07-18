#lang racket
(require racket/trace)

; Exercise 1.16
;
; Design a procedure that evolves an iterative exponentiation process that uses
; successive squaring and uses a logarithmic number of steps, as does fast-expt.
;

;;; --------------------------ANSWER:--------------------------------


(define (fast-expt b n)
    (define (even? n) (= (remainder n 2) 0))
    (define (square x) (* x x))
    (define (fast-expt-iter b n a)
        (cond ((= n 0) a)
              ((even? n) (fast-expt-iter (square b) (/ n 2) a))
              (else (fast-expt-iter b (- n 1) (* a b)))))
    (trace fast-expt-iter)
    (fast-expt-iter b n 1))

;;; --------------------------TEST:--------------------------------


(fast-expt 2 3)
