#lang racket

; Exercise 1.13:

; Prove that Fib(n)
;  is the closest integer to φ^n/√5
;  where φ=(1+√5)/2
;    Hint: Let ψ=(1−√5)/2
;    Use induction and the definition of the Fibonacci numbers (see 1.2.2) to prove that Fib(n)=(φ^n−ψ^n)/√5


;;; --------------------------ANSWER:--------------------------------

; (φ^0 - ψ^0) = 0
; (φ^0 - ψ^0)/√5 = 0
; 1. Base case: Fib(0) = 0 = (φ^0 - ψ^0)/√5
;
;
; Noticing that φ^2 = φ + 1 and ψ^2 = ψ + 1 are generalizable to φ^n = φ^(n-1) + φ^(n-2) and ψ^n = ψ^(n-1) + ψ^(n-2)
; we can easily substitute these into our equation after we group the like terms.

; 2. Inductive step: Fib(n) = Fib(n-1) + Fib(n-2)
;   (φ^n - ψ^n)/√5 = (φ^(n-1) - ψ^(n-1))/√5 + (φ^(n-2) - ψ^(n-2))/√5
;   (φ^n - ψ^n)/√5 = (φ^(n-1) + φ^(n-2) - ψ^(n-1) + ψ^(n-2))/√5   ; grouping like terms
;   (φ^n - ψ^n)/√5 = (φ^n - ψ^n)/√5                               ; substituting φ^n and ψ^n from above
;
