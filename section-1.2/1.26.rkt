#lang racket
(require racket/trace)

; Exercise 1.26
;
; Louis Reasoner is having great difficulty doing exercise 1.24.
; His fast-prime? test seems to run more slowly than his prime? test.
; Louis calls his friend Eva Lu Ator over to help. When they examine
; Louis's code, they find that he has rewritten the expmod procedure to
; use an explicit multiplication, rather than calling square:
;
; (define (expmod base exp m)
;   (cond ((= exp 0) 1)
;         ((even? exp)
;          (remainder (* (expmod base (/ exp 2) m)
;                        (expmod base (/ exp 2) m))
;                     m))
;         (else
;          (remainder (* base (expmod base (- exp 1) m))
;                     m))))
;
; "I don't see what difference that could make," says Louis. "I do."
; says Eva. "By writing the procedure like that, you have transformed
; the O(log n) process into a O(n) process." Explain.

;;; --------------------------ANSWER:--------------------------------

; The modified expmod procedure is O(n) because splitting the call to square into
; two calls to expmod means that the process will be a binary tree.
; Since expmod itself is O(log n), that makes the number of tree nodes(steps)
; 2^log n, which is n.

;;; --------------------------Testing:--------------------------------

(define (square x) (* x x))

(define (even? n) (= (remainder n 2) 0))

(define (r-expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (r-expmod base (/ exp 2) m)
                       (r-expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (r-expmod base (- exp 1) m))
                    m))))


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


; Original trace:
(trace expmod)
(expmod 2 10 17)


; Modified trace:
(trace r-expmod)
(r-expmod 2 10 17)
