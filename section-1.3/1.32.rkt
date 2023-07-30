#lang racket



; Exercise 1.32:
;
; a. Show that sum and product (exercise 1.31) are both special cases of a still
;    more general notion called accumulate that combines a collection of terms,
;    using some general accumulation function:
;
;    (accumulate combiner null-value term a next b)
;
;    accumulate takes as arguments the same term and range specifications as
;    sum and product, together with a combiner procedure (of two arguments) that
;    specifies how the current term is to be combined with the accumulation of
;    the preceding terms and a null-value that specifies what base value to use
;    when the terms run out. Write accumulate and show how sum and product can
;    both be defined as simple calls to accumulate.
;


;;; --------------------------ANSWER:--------------------------------

;Recursive definition of accumulate:
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

;Iterative definition of accumulate:
(define (i-accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner result (term a)))))
  (iter a null-value))

(define (sum term a next b)
  (i-accumulate + 0 term a next b))

(define (product term a next b)
  (i-accumulate * 1 term a next b))



;;; --------------------------Testing:--------------------------------


(define (inc x) (+ x 1))

(define (identity x) x)

(define (factorial x)
  (product identity 1 inc x))


(define (pi x)
  (define (term x)
    (* (/ (* 2 x) (- (* 2 x) 1)) (/ (* 2 x) (+ (* 2 x) 1))))
  (* 2.0 (product term 1 inc x)))


(factorial 5)
(pi 1000)



(define (cube x) (* x x x))

(define (simpson f a b n)
    (define h (/ (- b a) n))
    (define (y k) (f (+ a (* k h))))
    (define (term k)
        (cond ((or (= k 0) (= k n)) (y k))
            ((even? k) (* 2 (y k)))
            ((odd? k) (* 4 (y k)))))
    (* (/ h 3.0)
        (sum term 0 inc n)))

(simpson cube 0 1 100)
