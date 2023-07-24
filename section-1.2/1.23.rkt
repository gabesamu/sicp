#lang racket


; Exercise 1.23
;
; The smallest-divisor procedure shown at the start of this section does lots of needless testing:
; After it checks to see if the number is divisible by 2 there is no point in checking to see if it is
; divisible by any larger even numbers. This suggests that the values used for test-divisor should not be
; 2, 3, 4, 5, 6, ..., but rather 2, 3, 5, 7, 9, .... To implement this change, define a procedure (next) that
; returns 3 if its input is equal to 2 and otherwise returns its input plus 2. Modify the smallest-divisor
; procedure to use (next test-divisor) instead of (+ test-divisor 1). With timed-prime-test incorporating
; this modified version of smallest-divisor, run the test for each of the 12 primes found in exercise 1.22.
; Since this modification halves the number of test steps, you should expect it to run about twice as fast.
; Is this expectation confirmed? If not, what is the observed ratio of the speeds of the two algorithms,
; and how do you explain the fact that it is different from 2?

;;; --------------------------ANSWER:--------------------------------

; Implementing the Next procedure runs approximately twice as fast
;
; It's a bit less than twice because of the cost of the extra procedure call and the extra conditional
; Ratio is about 1.8 ish (just eyeballing it)
;


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
               (next test-divisor)))))

; Added this function
(define (next n)
  (if (= n 2) 3
       (+ n 2)))

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


(search-for-primes 1000000000000 3)
; now: ~2ms
; before: ~3ms

(search-for-primes 10000000000000 3)
; now: ~6ms
; before" ~10ms

(search-for-primes 100000000000000 3)
; now: ~18ms
; before: ~32ms

(search-for-primes 1000000000000000 3)
; now: ~56ms
; before: ~100ms
