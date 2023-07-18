#lang racket
(require racket/trace)

; Exercise 1.12:
;
; The following pattern of numbers is called Pascal's triangle.
;      1
;    1  1
;   1  2  1
;  1  3  3  1
; 1  4  6  4  1
; ...
; The numbers at the edge of the triangle are all 1, and each number
; inside the triangle is the sum of the two numbers above it. Write a
; procedure that computes elements of Pascal's triangle by means of a
; recursive process.

;;; --------------------------ANSWER:--------------------------------


(define (pascal row col)
  (cond ((= col 1) 1)
        ((= col row) 1)
        (else (+ (pascal (- row 1) (- col 1))
                 (pascal (- row 1) col)))))


;;; --------------------------Display:----------------------------------

(define (print-row row)
  (for ([i (in-range 1 (+ row 1))])
    (printf "~a " (pascal row i))))

(define (pascal-print row col)
    (cond ((= row 1) (print-row row))
            (else (begin (pascal-print (- row 1) col)
                         (newline)
                         (print-row row))))
    )

;;; --------------------------TEST:----------------------------------

(pascal 1 1)
; => 1

(pascal-print 5 5)
