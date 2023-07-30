#lang racket

;;; --------------------------Previous:--------------------------------

(define (square x)
  (* x x))

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


(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
    (find-divisor n 2))


; Exercise 1.33:
;
; You can obtain an even more general version of accumulate (exercise 1.32) by
; introducing the notion of a filter on the terms to be combined. That is, combine
; should be a procedure that takes two arguments: a term and a filter. Filter should
; be a predicate (a one-argument procedure that returns a Boolean value) that
; selects the terms to be combined. The resulting filtered-accumulate abstraction
; takes the same arguments as accumulate, together with an additional argument
; specifying the filter. Write filtered-accumulate as a procedure. Show how to
; express the following using filtered-accumulate:
;
; a. the sum of the squares of the prime numbers in the interval a to b (assuming
; that you have a prime? predicate already written)
;
; b. the product of all the positive integers less than n that are relatively prime to n
; (i.e., all positive integers i < n such that GCD(i,n) = 1).
;

;;; --------------------------ANSWER:--------------------------------

(define (identity x) x)

(define (inc x) (+ x 1))

(define (filtered-accumulate combiner null-value term a next b filter?)
    (define (iter a result)
        (if (> a b)
            result
            (if (filter? a)
                (iter (next a) (combiner (term a) result))
                (iter (next a) result))))
    (iter a null-value))

(define (sum-of-squares-of-primes a b)
    (filtered-accumulate + 0 square a inc b prime?))

(define (product-of-relatively-prime-integers n)
    (define (relatively-prime? a)
        (= (gcd a n) 1))
    (filtered-accumulate * 1 identity 1 inc n relatively-prime?))

(sum-of-squares-of-primes 1 10)

(product-of-relatively-prime-integers 10)
