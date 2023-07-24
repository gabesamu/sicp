#lang racket


; Exercise 1.24
;
; Modify the timed-prime-test procedure of exercise 1.22 to use fast-prime? (the Fermat method),
; and test each of the 12 primes you found in that exercise. Since the Fermat test has O(log n) growth,
; how would you expect the time to test primes near 1,000,000
; to compare with the time needed to test primes near 1000? Do your data bear this out?
; Can you explain any discrepency you find?


;;; --------------------------ANSWER:--------------------------------

(/ (log 1000000) (log 1000))  ; expected ratio between the two tests
; 2

; The tests average out to about that speed difference during testing.

;;; --------------------------Testing:--------------------------------

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

(define (square x)
  (* x x))

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
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))

(define (search-for-primes start num-of-primes)
    (define (iter n count)
        (cond ((= count 0) 'done)
            ((timed-prime-test n)
             (iter (+ n 2) (- count 1)))
            (else (iter (+ n 2) count))))
    (iter (+ start 1) num-of-primes))


(search-for-primes 1000 3)
; 18ms at 100000 fermat tests

(search-for-primes 10000000 3)
; 36ms at 100000 fermat tests
