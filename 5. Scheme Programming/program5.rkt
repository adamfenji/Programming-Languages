(define (wrap M)
(cond [(null? M) '()]
[(pair? (car M)) (cons (wrap (car M)) (wrap (cdr M)))]
[else (cons (list (car M)) (wrap (cdr M)))]))

(define (count-parens-all M)
(cond [(null? M) 2]
[(pair? (car M)) (+ 2 (count-parens-all (car M)) (count-parens-all (cdr M)))]
[else (+ 2 (count-parens-all (cdr M)))]))

(define (insert-left-all new old M)
(cond [(null? M) '()]
[(equal? (car M) old) (cons new (cons old (insert-left-all new old (cdr M))))]
[(pair? (car M)) (cons (insert-left-all new old (car M)) (insert-left-all new old (cdr M)))]
[else (cons (car M) (insert-left-all new old (cdr M)))]))

(define (invert M)
(if (null? M) '()
(cons (list (cadar M) (caar M)) (invert (cdr M)))))

(define (last a L)
(define (helper L idx lastIdx)
(cond [(null? L) lastIdx]
[(equal? a (car L)) (helper (cdr L) (+ idx 1) idx)]
[else (helper (cdr L) (+ idx 1) lastIdx)]))
(helper L 1 0))

(define (select pred L)
(cond [(null? L) '()]
[(pred (car L)) (cons (car L) (select pred (cdr L)))]
[else (select pred (cdr L))]))

(define (sumrow r1 r2)
(map + r1 r2))
(define (summatrices M1 M2)
(map sumrow M1 M2))

(define (swapper a1 a2 M)
(cond [(null? M) '()]
[(pair? (car M)) (cons (swapper a1 a2 (car M)) (swapper a1 a2 (cdr M)))]
[(equal? (car M) a1) (cons a2 (swapper a1 a2 (cdr M)))]
[(equal? (car M) a2) (cons a1 (swapper a1 a2 (cdr M)))]
[else (cons (car M) (swapper a1 a2 (cdr M)))]))

(define (flatten M)
(cond [(null? M) '()]
[(pair? (car M)) (append (flatten (car M)) (flatten (cdr M)))]
[else (cons (car M) (flatten (cdr M)))]))

(define (binary-tree-delete T n)
(define (min-node t)
(if (null? (car t)) (cadr t)
(min-node (car t))))
(cond [(null? T) '()]
[(< n (cadr T)) (list (binary-tree-delete (car T) n) (cadr T) (caddr T))]
[(> n (cadr T)) (list (car T) (cadr T) (binary-tree-delete (caddr T) n))]
[else (if (null? (car T))
(caddr T)
(if (null? (caddr T))
(car T)
(let ((min (min-node (caddr T))))
(list (car T) min (binary-tree-delete (caddr T) min)))))]))

(define (traverse f base combine M)
(cond [(null? M) base]
[(not (pair? (car M))) (combine (car M) (traverse f base combine (cdr M)))]
[else (cons (traverse f base combine (car M)) (traverse f base combine (cdr M)))]))
(define (rember* a M)
(traverse (lambda (x) (not (eq? a x))) '()
(lambda (x acc) (if (eq? x a) acc (cons x acc))) M))
(define (count* a M)
(traverse (lambda (x) (eq? x a)) 0
(lambda (x acc) (if (eq? x a) (+ 1 acc) acc)) M))