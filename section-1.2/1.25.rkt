#lang racket

; Exercise 1.25
;
; Alyssa P. Hacker complains that we went to a lot of extra work in writing expmod.
; After all, she says, since we already know how to compute exponentials, we could have simply written
;
; (define (expmod base exp m)
;   (remainder (fast-expt base exp) m))
;
; Is she correct? Would this procedure serve as well for our fast prime tester? Explain.



;;; --------------------------ANSWER:--------------------------------

; The reason this doesn't work as well is described in the book in footer 46.
;
; The original expmod function is taking advantage of
;  x * y mod m = ((x mod m) * (y mod m)) mod m
; The relation allows to split the exponentiation into smaller parts avoiding running into issues with large numbers.
;
; Alyssa's version does not do this and instead tries to calculate the entire exponentiation before taking the remainder.
; This causes the number to get quite huge which will slow down the computations significantly.


;;; --------------------------Testing:--------------------------------

(define (square x) (* x x))

(define (even? n) (= (remainder n 2) 0))

(define (fast-expt b n)
  (cond ((= n 0)
         1)
        ((even? n)
         (square (fast-expt b (/ n 2))))
        (else
         (* b (fast-expt b (- n 1))))))


(define (runtime) (current-milliseconds))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 100000)
      (report-prime n (- (runtime)
                       start-time))
        false))

(define (report-prime n elapsed-time)
  (newline)
  (display n)
  (display " *** ")
  (display elapsed-time))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n)
         (fast-prime? n (- times 1)))
        (else false)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))


(define (search-for-primes start num-of-primes)
    (define (iter n count)
        (cond ((= count 0) 'done)
            ((timed-prime-test n)
             (iter (+ n 2) (- count 1)))
            (else (iter (+ n 2) count))))
    (iter (+ start 1) num-of-primes))


(search-for-primes 1000 3)
; ~ 2000 ms

(search-for-primes 10000000 3)
; didnt let it finish
