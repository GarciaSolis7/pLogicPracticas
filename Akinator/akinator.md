# 🤖 Akinator de Ranma ½ en Lisp  

Este programa implementa un juego de preguntas tipo **Akinator** en **Common Lisp**, donde el usuario debe pensar en un personaje de *Ranma ½* y responder preguntas de **"sí" o "no"** hasta que el programa adivine el personaje.

El código utiliza **listas anidadas y recursión** para navegar en un árbol de decisiones basado en preguntas, hasta llegar a un personaje específico.

---

## 📌 **Estructura del Código**  

### 🔹 **Lista de Personajes (`*nodes*`)**  
El programa almacena la información en una estructura jerárquica que representa un **árbol de decisión**.  

```lisp
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
```
### 🔹 **Funciones**  
Despues se tienen las funciones para recorrer e iniciar el programa.
```lisp
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
```
