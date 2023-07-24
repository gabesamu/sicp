#lang racket

; Exercise 1.22:
;
; Most Lisp implementations include a primitive called runtime that returns an
; integer that specifies the amount of time the system has been running (measured,
; for example, in microseconds). The following timed-prime-test procedure, when
; called with an integer n, prints n and checks to see if n is prime. If n is
; prime, the procedure prints three asterisks followed by the amount of time used
; in performing the test.
;
; Using this procedure, write a procedure search-for-primes that checks the
; primality of consecutive odd integers in a specified range. Use your procedure
; to find the three smallest primes larger than 1000; larger than 10,000; larger
; than 100,000; larger than 1,000,000. Note the time needed to test each prime.
; Since the testing algorithm has order of growth of Θ(√n), you should expect
; that testing for primes around 10,000 should take about √10 times as long as
; testing for primes around 1000. Do your timing data bear this out? How well do
; your data agree with the Θ(√n) prediction? Is your result compatible with the
; notion that programs on your machine run in time proportional to the number of
; steps required for the computation?

;;; --------------------------ANSWER:--------------------------------

; (search-for-primes 1000 1020)
; (search-for-primes 10000 10020)
; (search-for-primes 100000 100090)
; (search-for-primes 1000000 1000090)

; Need to use larger numbers to see any difference with my machine.

; (search-for-primes 1000000000000 3)
; ~3ms

; (search-for-primes 10000000000000 3)
; ~10ms

; (search-for-primes 100000000000000 3)
; ~32ms

; (search-for-primes 1000000000000000 3)
; ~100ms

; (sqrt 10)
; Seem to grow at ~√10 for every 10x increase in n.

;;; --------------------------Testing:--------------------------------

(define (runtime) (current-milliseconds))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (runtime)
                       start-time))
        false))

(define (report-prime n elapsed-time)
  (newline)
  (display n)
  (display " *** ")
  (display elapsed-time))

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

(define (prime? n)
  (= n (smallest-divisor n)))


(define (search-for-primes start num-of-primes)
    (define (iter n count)
        (cond ((= count 0) 'done)
            ((timed-prime-test n)
             (iter (+ n 2) (- count 1)))
            (else (iter (+ n 2) count))))
    (iter (+ start 1) num-of-primes))

; (search-for-primes 1000 1020)
; (search-for-primes 10000 10020)
; (search-for-primes 100000 100090)
; (search-for-primes 1000000 1000090)

; Need to use larger numbers to see any difference with my machine.

(search-for-primes 1000000000000 3)
; ~3ms
(search-for-primes 10000000000000 3)
; ~10ms

(search-for-primes 100000000000000 3)
; ~32ms

(search-for-primes 1000000000000000 3)
; ~100ms

(sqrt 10)
; Seem to grow at ~√10 for every 10x increase in n.
