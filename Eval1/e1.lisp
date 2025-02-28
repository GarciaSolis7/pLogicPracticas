;e1
(defun primer-elemento (lst)
  (if (null lst)
      nil
      (car lst)))


;e2
(defun segundo-elemento (lst)
  (if (or (null lst) (null (cdr lst)))
      nil
      (car (cdr lst))))


  ;e3

(defun ultimo-elemento (lst)
  (if (null (cdr lst))
      (car lst)
      (ultimo-elemento (cdr lst))))


;e4
(defun longitud-lista (lst)
  (if (null lst)
      0
      (+ 1 (longitud-lista (cdr lst)))))


;e5

(defun suma-lista (lst)
  (if (null lst)
      0
      (+ (car lst) (suma-lista (cdr lst)))))


;e6
(defun pertenece (elem lst)
  (if (null lst)
      nil
      (if (equal elem (car lst))
          t
          (pertenece elem (cdr lst)))))



;e7
(defun invertir-lista (lst)
  (if (null lst)
      nil
      (append (invertir-lista (cdr lst)) (list (car lst)))))


;e8
(defun eliminar-ocurrencias (elem lst)
  (if (null lst)
      nil
      (if (equal elem (car lst))
          (eliminar-ocurrencias elem (cdr lst))
          (cons (car lst) (eliminar-ocurrencias elem (cdr lst))))))


;e9
(defun enesimo-elemento (n lst)
  (if (or (null lst) (< n 0))
      nil
      (if (= n 0)
          (car lst)
          (enesimo-elemento (- n 1) (cdr lst)))))


;e10
(defun concatenar-listas (lst1 lst2)
  (if (null lst1)
      lst2
      (cons (car lst1) (concatenar-listas (cdr lst1) lst2))))
