#lang racket

; Exercise 1.27
;
; Demonstrate that the Carmichael numbers really do fool the Fermat test.
; Write a procedure that takes an integer n and tests whether a^n is congruent
; to a modulo n for every a < n, and try your procedure on the given Carmichael
; numbers.

;;; --------------------------ANSWER:--------------------------------


(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))

(define (square x) (* x x))

(define (carmichael-test n)
  (define (try-it n a)
    (cond ((= a 1) true)
          ((= (expmod a n n) a) (try-it n (- a 1)))
          (else false)))
  (try-it n (- n 1)))

(carmichael-test 561)
(carmichael-test 1105)
(carmichael-test 1729)
(carmichael-test 2465)
(carmichael-test 2821)
(carmichael-test 6601)
