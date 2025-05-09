#lang lazy

(define f-list
(letrec ((f (lambda (n)
(cond [(= n 0) 1]
[(= n 1) 2]
[(= n 2) 3]
[else (+ (* 2 (f (- n 1))) (* 3 (f (- n 3)))]))))
(map f (stream-from 0))))