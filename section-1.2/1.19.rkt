#lang racket

; Exercise 1.19:
;
; There is a clever algorithm for computing the Fibonacci numbers in a
; logarithmic number of steps. Recall the transformation of the state
; variables a and b in the fib-iter process of section 1.2.2:
;
; a <- a + b
; b <- a
;
; Call this transformation T, and observe that applying T over and over
; again n times, starting with 1 and 0, produces the pair Fib(n + 1)
; and Fib(n). In other words, the Fibonacci numbers are produced by
; applying T^n, the nth power of the transformation T, starting with
; the pair (1,0). Now consider T to be the special case of p = 0 and q
; = 1 in a family of transformations T_pq, where T_pq transforms the
; pair (a,b) according to
;
; a <- bq + aq + ap
; b <- bp + aq
;
; Show that if we apply such a transformation T_pq twice, the effect
; is the same as using a single transformation T_p'q' of the same
; form, and compute p' and q' in terms of p and q. This gives us an
; explicit way to square these transformations, and thus we can
; compute T^n using successive squaring, as in the fast-expt
; procedure. Put this all together to complete the following
; procedure, which runs in a logarithmic number of steps:





;;; --------------------------ANSWER:--------------------------------


; Our goal is to find the values of p' and q' such that
; T_pq(T_pq(a,b)) = T_p'q'(a,b). We can try do this by
; fully expanding T_pq(T_pq(a,b)) and performing some algebraic
; manipulation to get it into the form of T_p'q'(a,b).
;
; The full expansion of T_pq(T_pq(a,b)) is:
;
; a = (bq + aq + ap)q + (bp + aq)q + (bq + aq + ap)p
; b = (bp + aq)p + (bq + aq + ap)q
;
; lets multiply p and q through:

; a = bq^2 + aq^2 + apq + bpq + aq^2 + bqp + aqp + ap^2
; b = bp^2 + aqp + bq^2 + aq^2 + apq
;
; lets then rearrange the terms to somewhat resemble the original equations
;
; a = (bq^2 + 2bqp) + (aq^2 + 2aqp) + (ap^2 + aq^2)
; b = (bq^2 + bp^2) + (aq^2 + 2aqp)
;
; And once we factor out the common terms, we get:
;
; a = b(q^2 + 2qp) + a(q^2 + 2qp) + a(p^2 + q^2)
; b = b(q^2 + p^2) + a(q^2 + 2qp)
;
; Now comparing this with the first set of equations, we can see that
;   p' = p^2 + q^2
;   q' = q^2 + 2qp


(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0)
         b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))  ;compute p'
                   (+ (* q q) (* 2 q p))  ;compute q'
                   (/ count 2)))
        (else
         (fib-iter (+ (* b q)
                      (* a q)
                      (* a p))
                   (+ (* b p)
                      (* a q))
                   p
                   q
                   (- count 1)))))


(fib 8)
