#lang racket



; Exercise 1.30:
;
; The sum procedure above generates a linear recursion. The procedure can be
; rewritten so that the sum is performed iteratively. Show how to do this by
; filling in the missing expressions in the following definition:
;
; (define (sum term a next b)
;   (define (iter a result)
;     (if <??>
;         <??>
;         (iter <??> <??>)))
;   (iter <??> <??>))
;


;;; --------------------------ANSWER:--------------------------------


(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))

  (iter a 0))



;;; --------------------------Testing:--------------------------------


(define (cube x) (* x x x))

(define (inc n) (+ n 1))

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
