#lang racket
(require racket/trace)

; Exercise 1.11:
;
; A function f
; is defined by the rule that
; f(n)=n
; if n<3
;
; and f(n)=f(n-1)+2f(n-2)+3f(n-3)
; if n≥3
;
; Write a procedure that computes f
; by means of a recursive process.
;
; Write a procedure that computes f
; by means of an iterative process.




;;; --------------------------ANSWER:--------------------------------

; Recursive implementation:

(define (recursive-f n)
   (cond ((< n 3) n)
          (else (+ (recursive-f (- n 1)) (* 2 (recursive-f (- n 2))) (* 3 (recursive-f (- n 3)))))))

; (trace recursive-f)


(recursive-f 2)



; Iterative implementation:

(define (iterative-f n)
    (define (iter c c-1 c-2 count) ; c = answer at current iteration, c-1 = current - 1, c-2 = current - 2
        (cond ((= count n) c)
              (else (iter (+ c (* 2 c-1) (* 3 c-2)) c c-1 (+ count 1)))))

    (cond ((< n 3) n)
            (else (iter 2 1 0 2))))

 ;(trace iterative-f)

(iterative-f 3)
