#lang racket

; Exercise 1.21:
;
; Use the smallest-divisor procedure to find the smallest divisor of each of the
; following numbers: 199, 1999, 19999.

;;; --------------------------ANSWER:--------------------------------

; smallest-divisor-of 199 => 199
; smallest-divisor-of 1999 => 1999
; smallest-divisor-of 19999 => 7

;;; --------------------------Testing:----------------------------------

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n)
         n)
        ((divides? test-divisor n)
         test-divisor)
        (else (find-divisor
               n
               (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square x)
  (* x x))

(define (smallest-divisor-of n)
    (display "smallest-divisor-of ")
  (display n)
  (display " => ")
  (display (smallest-divisor n))
  (newline))

(smallest-divisor-of 199)

(smallest-divisor-of 1999)

(smallest-divisor-of 19999)
