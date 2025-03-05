(defparameter *nodes*
  '((canon
     (femenino
      (pelo-rojo
       (luchadora ranma-femenino)
       (extranjera shampoo)
       (cocinera ukyo))
      (pelo-azul
       (luchadora kodachi)
       (timida hinako))
      (pelo-morado
       (ninja konatsu)
       (amazona cologne)))
     (masculino
      (con-coleta
       (protagonista ranma-masculino)
       (rival ryoga))
      (calvo
       (anciano happosai)
       (sabio cologne))
      (pelo-largo
       (poderoso mousse)
       (seductor tatewaki-kuno))
      (gordo
       (panda genma)
       (maestro soun)))
     (animal
      (cerdo ryoga-cerdo)
      (gato shampoo-gato)
      (pato mousse-pato)
      (panda genma-panda))))
      )
(defun recorre (lista)
  (when lista
    (let ((elemento (car lista)))
      (if (atom elemento)
          (format t "Tu personaje es ~a!~%" elemento)
          (progn
            (format t "Tu personaje es ~a? (si/no)~%" (car elemento))
            (setq respuesta (read))
            (if (string-equal respuesta "si")
                (recorre (cdr elemento)) 
                (recorre (cdr lista))))))))



(defun iniciar ()
  (format t "Piensa en un personaje de Ranma y responde a las preguntas con 'si' o 'no'.~%")
  (recorre *nodes*))
