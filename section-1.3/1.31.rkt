#lang racket

; Exercise 1.31:
;
; The sum procedure is only the simplest of a vast number of similar abstractions
; that can be captured as higher-order procedures. Write an analogous procedure
; called product that returns the product of the values of a function at points
; over a given range. Show how to define factorial in terms of product. Also use
; product to compute approximations to pi using the formula
;
; pi/4 = (2 * 4 * 4 * 6 * 6 * 8 * ...) / (3 * 3 * 5 * 5 * 7 * 7 * ...)
;
; If your product procedure generates a recursive process, write one that
; generates an iterative process. If it generates an iterative process, write
; one that generates a recursive process.


;;; --------------------------ANSWER:--------------------------------


(define (identity x) x)

(define (inc x) (+ 1 x) )

(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))

  (iter a 1))

(define (factorial x)
  (product identity 1 inc x))



(define (pi x)
  (define (term x)
    (* (/ (* 2 x) (- (* 2 x) 1)) (/ (* 2 x) (+ (* 2 x) 1))))
  (* 2.0 (product term 1 inc x)))




(factorial 5)
(pi 1000)
