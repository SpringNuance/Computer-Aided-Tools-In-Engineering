;--------------------------------INFO---------------------------------------------------------------
;	SEURAAVAN FUNKTION PARSIJA LOKAALIT MUUTTUJAT: --- Nollautuu funktion päätyttyä
;Excel-taulukossa parametrit ovat yhdessä ketjussa, jos seuraava merkki on ; poistetaan se ja korvataan välilyönnillä

;KESTIO 	- Tutkii yhden merkin kerrallaan
;LISTAX 	- Lista johon parametrit lisätään, funktio palauttaa tämän
;---------------------------------------------------------------------------------
(defun PARSIJA (RIVI / VÄLI KESTO LISTAX);formatoi tiedoston rivin oikeanlaiseksi
  (setq KESTO 1)
  (setq VÄLI "")
  (setq LISTAX nil)
  (repeat (strlen RIVI)
    (if (= (substr RIVI KESTO 1) ",")
      (progn
	(setq LISTAX (append LISTAX (list (atof VÄLI)))
	      VÄLI ""))
      (setq VÄLI (strcat VÄLI (substr RIVI KESTO 1))))
    (setq KESTO (1+ KESTO)))
  (setq LISTAX (append LISTAX (list (atof VÄLI))))
  );defun
;-----------------------------------PARSIJA_LOPPU----------------------------------------------------

;---------------------------------------INFO---------------------------------------------------------
;	SEURAAVAN FUNKTION PARSI_X LOKAALIT MUUTTUJAT:  ---- Nollautuu funktion päätyttyä
;LASKURI 	- While looppia varten
;LASKURI_2 	- Tarvitaaan toinen laskuri (nested loop) 
;PISTE_PITUUS 	- Pisteet sisältävän listan pituus
;X_PISTEET 	- Pisteiden X-koordinaatit joista lasketaan mitat
;X_MITAT 	- Lista johon X-koordinaattien etäisyydet lisätään, ja joka palautetaan funktion lopussa
;PISTE 		- Input listan ensimmäinen piste - elää funktion aikana
;RO 		- Pyöristys muuttuja
;ENSIMMÄINEN	- Ensimmäinen listan jäsen, joka saa uusia arvoja loopin edetessä
;TOINEN 	- Muuttuja, jolla lasketaan ENSIMMÄINEN- muuttujan avulla Y-koordinaattien etäisyys
;J 		- Etäisyys
;TOISTO 	- Repeat & while loopin toistomäärät

;	SEURAAVAN FUNKTION INPUT
;RETURN 	- Tietyn tason pisteet, jotka halutaan parsia sekä laskea etäisyyksiä
;-----------------------------------PISTEEN_LASKIJA_X--------------------------------------------
(defun PISTEEN_LASKIJA_X ( RETURN / LASKURI PISTE_PITUUS X_PISTEET PISTE XP RO LASKURI_2 ENSIMMÄINEN TOINEN J TOISTO X_MITAT)
  (setq LASKURI 0
	PISTE_PITUUS (length RETURN)
	X_PISTEET (list))
  (while (< LASKURI PISTE_PITUUS)
    (setq PISTE (nth LASKURI RETURN)
	  XP (car PISTE)
	  ;RO 0.1 ;pyöristää luvut kymmenesosien tarkkuuteen
	  ;XP (* RO (atoi (rtos (/ XP (float RO)) 2 0)))
	  X_PISTEET (cons XP X_PISTEET)  
	  LASKURI (1+ LASKURI)));while 

;Tutkitaan jokainen mahdollinen kahden pisteet etäisyys X listasta. 
  (setq LASKURI_2 0
	ENSIMMÄINEN (nth LASKURI_2 X_PISTEET)
	X_MITAT (list))
  (repeat (setq TOISTO (length X_PISTEET))
    (setq LASKURI 0
	  TOINEN (nth LASKURI X_PISTEET))
    (while (< LASKURI TOISTO)
      (setq j (- ENSIMMÄINEN TOINEN)
	    j (abs j)
	    X_MITAT (cons j X_MITAT)
	    LASKURI (1+ LASKURI)
	    TOINEN (nth LASKURI X_PISTEET)));while
    (setq LASKURI_2 (1+ LASKURI_2))
    (setq ENSIMMÄINEN (nth LASKURI_2 X_PISTEET))	
    );repeat
  (princ X_MITAT)
  )
;-----------------------------------PISTEEN_LASKIJA_X--------------------------------------------

;---------------------------------------INFO---------------------------------------------------------
;	SEURAAVAN FUNKTION PARSI_Y LOKAALIT MUUTTUJAT:  ---- Nollautuu funktion päätyttyä
;LASKURI 	- While looppia varten
;LASKURI_2 	- Tarvitaaan toinen laskuri (nested loop) 
;PISTE_PITUUS 	- Pisteet sisältävän listan pituus
;Y_PISTEET 	- Pisteiden y-koordinaatit joista lasketaan mitat
;Y_MITAT 	- Lista johon Y-koordinaattien etäisyydet lisätään, ja joka palautetaan funktion lopussa
;PISTE 		- Input listan ensimmäinen piste - elää funktion aikana
;RO 		- Pyöristys muuttuja
;ENSIMMÄINEN 	- Ensimmäinen listan jäsen, joka saa uusia arvoja loopin edetessä
;TOINEN 	- Muuttuja, jolla lasketaan ENSIMMÄINEN- muuttujan avulla X-koordinaattien etäisyys
;J 		- Etäisyys
;TOISTO 	- Repeat & while loopin toistomäärät

;	SEURAAVAN FUNKTION INPUT
;RETURN 	- Tietyn tason pisteet, jotka halutaan parsia sekä laskea etäisyyksiä
;-----------------------------------PISTEEN_LASKIJA_Y--------------------------------------------
(defun PISTEEN_LASKIJA_Y (RETURN / LASKURI PISTE_PITUUS Y_PISTEET PISTE RO LASKURI_2 ENSIMMÄINEN Y_MITAT TOINEN J TOISTO)
  (setq LASKURI 0
	PISTE_PITUUS (length RETURN)
	Y_PISTEET (list))

  (while (< LASKURI PISTE_PITUUS)
    (setq PISTE (nth LASKURI RETURN)
	  PISTE (cadr PISTE)
	  ;RO 0.1 ;pyöristää luvut kymmenesosien tarkkuuteen
	  ;PISTE (* RO (atoi (rtos (/ PISTE (float RO)) 2 0)))	
	  Y_PISTEET (cons PISTE Y_PISTEET)
	  LASKURI (1+ LASKURI)));while

  (setq LASKURI_2 0
	ENSIMMÄINEN (nth LASKURI_2 Y_PISTEET)
	Y_MITAT (list))
  (repeat (setq TOISTO (length Y_PISTEET))
    (setq LASKURI 0
	  TOINEN (nth LASKURI Y_PISTEET))
    (while (< LASKURI TOISTO)
      (setq j (- ENSIMMÄINEN TOINEN)
	    j (abs j)
	    Y_MITAT (cons j Y_MITAT)
	    LASKURI (1+ LASKURI)
	    TOINEN (nth LASKURI Y_PISTEET)));while
    (setq LASKURI_2 (1+ LASKURI_2))
    (setq ENSIMMÄINEN (nth LASKURI_2 Y_PISTEET))	
    );repeat
  (princ Y_MITAT)
  )
;-----------------------------------PISTEEN_LASKIJA_Y--------------------------------------------

;---------------------------------------INFO---------------------------------------------------------
;	SEURAAVAN FUNKTION PARSI_Y LOKAALIT MUUTTUJAT:  ---- Nollautuu funktion päätyttyä
;LASKURI 	- While looppia varten
;PISTE_PITUUS 	- Pisteet sisältävän listan pituus
;Y_KOORDINAATIT - Pisteiden y-koordinaatit jotka palautetaan funktion lopussa
;PISTE 		- Input listan ensimmäinen piste - elää funktion aikana
;RO 		- Pyöristys muuttuja

;	SEURAAVAN FUNKTION INPUT
;PISTEET 	- Tietyn tason pisteet, jotka halutaan parsia
;-----------------------------------PARSI_Y----------------------------------------------------
(defun PARSI_Y (PISTEET / LASKURI PISTE_PITUUS Y_KOORDINAATIT PISTE RO)
  (setq LASKURI 0
	PISTE_PITUUS (length PISTEET)
	Y_KOORDINAATIT (list))

  (while (< LASKURI PISTE_PITUUS)
    (setq PISTE (nth LASKURI PISTEET)
	  PISTE (cadr PISTE)
	  ;RO 0.1 ;pyöristää luvut kymmenesosien tarkkuuteen
	  ;PISTE (* RO (atoi (rtos (/ PISTE (float RO)) 2 0)))	
	  Y_KOORDINAATIT (cons PISTE Y_KOORDINAATIT)
	  LASKURI (1+ LASKURI)));while
  (princ Y_KOORDINAATIT)
  )
;-----------------------------------PARSI_Y LOPPU----------------------------------------------------

;---------------------------------------INFO---------------------------------------------------------
;	SEURAAVAN FUNKTION PARSI_X LOKAALIT MUUTTUJAT:  ---- Nollautuu funktion päätyttyä
;LASKURI 	- Phile looppia varten
;PISTE_PITUUS 	- Pisteet sisältävän listan pituus
;Y_KOORDINAATIT - Pisteiden X-koordinaatit jotka palautetaan funktion lopussa
;PISTE 		- Input listan ensimmäinen piste - elää funktion aikana
;RO 		- Pyöristys muuttuja

;	SEURAAVAN FUNKTION INPUT
;PISTEET 	- Tietyn tason pisteet, jotka halutaan parsia
;-----------------------------------PARSI_X----------------------------------------------------
(defun PARSI_X (PISTEET / LASKURI PISTE_PITUUS X_KOORDINAATIT LASKURI PISTE RO)
  (setq LASKURI 0
	PISTE_PITUUS (length PISTEET)
	X_KOORDINAATIT (list))

  (while (< LASKURI PISTE_PITUUS)
    (setq PISTE (nth LASKURI PISTEET)
	  PISTE (car PISTE)
	  ;RO 0.1 ;pyöristää luvut kymmenesosien tarkkuuteen
	  ;PISTE (* RO (atoi (rtos (/ PISTE (float RO)) 2 0)))	
	  X_KOORDINAATIT (cons PISTE X_KOORDINAATIT)
	  LASKURI (1+ LASKURI)));while
  (princ X_KOORDINAATIT)
  )
;-----------------------------------PARSI_X----------------------------------------------------

;---------------------------------------INFO---------------------------------------------------------
;	SEURAAVAN FUNKTION LOKAALIT MUUTTUJAT:  ---- Nollautuu funktion päätyttyä
;RETURN 	- Palauttaa anturat tason piirustusobjektien pisteet listassa
;SSPITUUS	- Selection setin pituus
;ENTITY & ENTS 	- Selection Setin jäsen (esim yksi viiva) ja sen ominaisuus (esim. linetype)
;X_PISTEET 	- Funktion pallauttama lista, jossa anturoiden x-pisteiden etäisyydet
;Y_PISTEET 	- Funktion pallauttama lista, jossa anturoiden y-pisteiden etäisyydet
;MITTA_PITUUDET - Montako mittaa on listassa
;ENSIMMÄINEN 	- Listan ensimmäinen mitta --> muuttuu while loopin mukaisesti
;LASKURI 	- Erilaisten toistojen (looppien) käyttöä varten
;LST 		- Muuttuja, joka sisältää DXF-koodin 10 tiedon eli pisteen esim. (120.50 134.45)
;MÄÄRÄ 		- Muuttuja, joka sisältää oikeiden haluttujen mittojen määrän 

;	SEURAAVAN FUNKTION INPUT
;ANTURASS 	- Antura tason selection set
;ANTD 		- Haluttu anturoiden välinen etäisyys
;ANTH 		- Haluttu anturoiden välinen korkotaso
;TF (Text File) - Tiedosto johon kommentit tulostuvat
;-----------------------------------ANTURA_ANALYYSI----------------------------------------------

(defun ANTURA_ANALYYSI (ANTURASS ANTD ANTH AL AK TF / RETURN SSPITUUS ENTITY ENTS LASKURI LST X_PISTEET Y_PISTEET MITTA_PITUUDET ENSIMMÄINEN MÄÄRÄ)
  (setq RETURN nil)
  (if (= (sslength ANTURASS) 2)(progn
				 (write-line " -Right number of objects and right drawing technique is used (POLYLINE). Check if there is overlapping objects. \t1p"TF)
				 (setq ARVOSANA (1+ ARVOSANA)))
    (write-line " -Objects are drawn with correct technique, but there is too many or too few of them on the FOUNDATIONS layer" TF))
  (repeat (setq SSPITUUS (sslength ANTURASS))
     (setq ENTITY (ssname ANTURASS (setq SSPITUUS (1- SSPITUUS))))
     (setq ENTS (entget ENTITY))
     (while (setq LST (assoc 10 ENTS))
	(setq RETURN (cons (cdr LST) RETURN) ENTS (cdr (member LST ENTS)))
	);while
     );repeat
  

  (setq X_PISTEET (PISTEEN_LASKIJA_X RETURN);laskee x-suunnan etäisyydet
	Y_PISTEET (PISTEEN_LASKIJA_Y RETURN));laskee y-suunnan etäisyydet

;anturan koko
	;leveys
   (setq MITTA_PITUUDET (length X_PISTEET)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI X_PISTEET)
	MÄÄRÄ (list))
  
  (while (< LASKURI MITTA_PITUUDET)
    (if (= (rtos ENSIMMÄINEN) (rtos AL))(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI X_PISTEET)));while

  (if (>= (length MÄÄRÄ) 16)(progn
			     (write-line " -Width of the foundations is correct \t1p " TF)
			     (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -Check the width of the foundations" TF))

   	;korkeus
   (setq MITTA_PITUUDET (length Y_PISTEET)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI Y_PISTEET)
	MÄÄRÄ (list))
  
  (while (< LASKURI MITTA_PITUUDET)
    (if (= (rtos ENSIMMÄINEN) (rtos AK))(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI Y_PISTEET)));while

  (if (>= (length MÄÄRÄ) 16)(progn
			     (write-line " -Height of the foundations is correct \t1p " TF)
			     (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -Check heights of the foundations" TF))

   
   
;X-suunnan tarkastelu
  (setq MITTA_PITUUDET (length X_PISTEET)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI X_PISTEET)
	MÄÄRÄ (list))
  
  (while (< LASKURI MITTA_PITUUDET)
    (if (= (rtos ENSIMMÄINEN) (rtos ANTD))(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI X_PISTEET)));while

  (if (>= (length MÄÄRÄ) 14)(progn
			     (write-line " -Distance of the foundations in X-direction is correct \t1p  " TF)
			     (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -Distance of the foundations in X-direction is incorrect. Check the distance and drawing technique" TF))
  (setq X_PISTEET nil)

;Y-suunnan tarkastelu
  (setq MITTA_PITUUDET (length Y_PISTEET)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI Y_PISTEET)
	MÄÄRÄ (list))
  
  (while (< LASKURI MITTA_PITUUDET)
    (if (= (rtos ENSIMMÄINEN) (rtos ANTH))(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI Y_PISTEET)));while

  (if (>= (length MÄÄRÄ) 14)(progn
			     (write-line " -Distance of the foundations in Y-direction is correct \t1p " TF)
			     (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -Distance of the foundations in Y-direction is incorrect. Check the distance and drawing technique" TF))
  (setq Y_PISTEET nil)
  
  (princ RETURN)
  );defun

;------------------------------ANTURA_ANALYYSI LOPPU---------------------------------------------------

;---------------------------------------INFO---------------------------------------------------------
;	SEURAAVAN FUNKTION LOKAALIT MUUTTUJAT:  ---- Nollautuu funktion päätyttyä
;RETURN 	- Palauttaa perusjalkojen piirustusobjektien pisteet
;SSPITUUS	- Selection setin pituus
;ENTITY & ENTS 	- Selection Setin jäsen (esim yksi viiva) ja sen ominaisuus (esim. linetype)
;X_PISTEET	- Funktion pallauttama lista, jossa perusjalkojen x-pisteiden etäisyydet
;Y_PISTEET 	- Funktion pallauttama lista, jossa perusjalkojen y-pisteiden etäisyydet
;MITTA_PITUUDET - Montako mittaa on listassa
;ENSIMMÄINEN 	- Listan ensimmäinen mitta --> kasvaa while loopin mukaisesti
;LASKURI 	- Erilaisten toistojen (looppien) käyttöä varten
;LST 		- Muuttuja, joka sisältää DXF-koodin 10 tiedon eli pisteen esim. (120.50 134.45)
;MÄÄRÄ 		- Muuttuja, joka sisältää oikeiden haluttujen mittojen määrän 

;	SEURAAVAN FUNKTION INPUT
;PERUSJALKASS 	- Perusjalka tason selection set
;ANTD 		- Haluttu perusjalkojen välinen etäisyys
;ANTH 		- Haluttu perusjalkojen välinen korkotaso
;TF (Text File) - Tiedosto johon kommentit tulostuvat
;------------------------------PERUSJALKA_ANALYYSI ALKU-----------------------------------------------
(defun PERUSJALKA_ANALYYSI (PERUSJALKASS ANTD ANTH TF / RETURN SSPITUUS ENTITY ENTS LST LASKURI X_PISTEET Y_PISTEET MITTA_PITUUDET ENSIMMÄINEN MÄÄRÄ)
  (setq RETURN nil)
  (if (= (sslength PERUSJALKASS) 2)(progn
				     (write-line " -Right number of objects and right drawing technique used (BLOCK INSERT) \t1p" TF)
				     (setq ARVOSANA (1+ ARVOSANA)))
    (write-line " -Number of objects on the layer is incorrect" TF))
  (repeat (setq SSPITUUS (sslength PERUSJALKASS))
     (setq ENTITY (ssname PERUSJALKASS (setq SSPITUUS (1- SSPITUUS))))
     (setq ENTS (entget ENTITY))
     (while (setq LST (assoc 10 ENTS))
	(setq RETURN (cons (cdr LST) RETURN) ENTS (cdr (member LST ENTS)))
	);while
     );repeat
  

  (setq X_PISTEET (PISTEEN_LASKIJA_X RETURN));laskee x-suunnan etäisyydet
  (setq Y_PISTEET (PISTEEN_LASKIJA_Y RETURN));laskee y-suunnan etäisyydet

;X-suunnan tarkastelu
  (setq MITTA_PITUUDET (length X_PISTEET)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI X_PISTEET)
	MÄÄRÄ (list))
  
  (while (< LASKURI MITTA_PITUUDET)
    (if (= (rtos ENSIMMÄINEN) (rtos ANTD))(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI X_PISTEET)));while

  (if (= (length MÄÄRÄ) 2)(progn
			     (write-line " -Distance of the pedestals in X-direction is correct \t1p " TF)
			     (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -Distance of the pedestals in X-direction is incorrect. Check the distance and drawing technique" TF))
  (setq X_PISTEET nil)

;Y-suunnan tarkastelu
  (setq MITTA_PITUUDET (length Y_PISTEET)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI Y_PISTEET)
	MÄÄRÄ (list))
  
  (while (< LASKURI MITTA_PITUUDET)
    (if (= (rtos ENSIMMÄINEN) (rtos ANTH))(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI Y_PISTEET)));while

  (if (>= (length MÄÄRÄ) 2)(progn
			     (write-line " -Distance of the pedestals in Y-direction is correct \t1p " TF)
			     (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -Distance of the pedestals in Y-direction is incorrect. Check the distance and drawing technique" TF))
  (setq Y_PISTEET nil)

  
  (princ RETURN)
  );defun

;-------------------------------------------PERUSJALKA_ANALYYSI ALKU-------------------------------------

;---------------------------------------INFO---------------------------------------------------------
;	SEURAAVAN FUNKTION LOKAALIT MUUTTUJAT:  ---- Nollautuu funktion päätyttyä
;RETURN 	- Palauttaa pilareiden piirustusobjektien pisteet
;SSPITUUS	- Selection setin pituus
;ENTITY & ENTS 	- Selection Setin jäsen (esim yksi viiva) ja sen ominaisuus (esim. linetype)
;X_PISTEET	- Funktion pallauttama lista, jossa pilareiden x-pisteiden etäisyydet
;Y_PISTEET 	- Funktion pallauttama lista, jossa pilareiden y-pisteiden etäisyydet
;MITTA_PITUUDET - Montako mittaa on listassa
;ENSIMMÄINEN 	- Listan ensimmäinen mitta --> kasvaa while loopin mukaisesti
;LASKURI 	- Erilaisten toistojen (looppien) käyttöä varten
;LST 		- Muuttuja, joka sisältää DXF-koodin 10 tiedon eli pisteen esim. (120.50 134.45)
;MÄÄRÄ 		- Muuttuja, joka sisältää oikeiden haluttujen mittojen määrän 

;	SEURAAVAN FUNKTION INPUT
;PILARISS 	- Perusjalka tason selection set
;ANTD 		- Haluttu perusjalkojen välinen etäisyys
;ANTH 		- Haluttu perusjalkojen välinen korkotaso
;TF (Text File) - Tiedosto johon kommentit tulostuvat
;-------------------------------------------PILARI_ANALYYSI ALKU-----------------------------------------
(defun PILARI_ANALYYSI (PILARISS ANTD ANTH PROF_MITTA TF / RETURN SSPITUUS ENTITY ENTS LST LASKURI MITTA_PITUUDET ENSIMMÄINEN Y_PISTEET X_PISTEET MÄÄRÄ)
  (setq RETURN nil)
  (if (or
	(< (sslength PILARISS) 4)
	(> (sslength PILARISS) 8))(progn
				 (write-line " -There should be less than 8 columns in the drawing. Columns can be drawn as seperate lines or joint object (Polyline). Note that the steel plates cut the colums in initial data drawing. Check for overlapping objects." TF))
	(progn
	  (write-line " -There is correct number of objects on the layer (4-8 pieces) \t1p" TF)
	  (setq ARVOSANA (+ ARVOSANA 1))))

  (repeat (setq SSPITUUS (sslength PILARISS))
     (setq ENTITY (ssname PILARISS (setq SSPITUUS (1- SSPITUUS))))
     (setq ENTS (entget ENTITY))
     (while (setq LST (assoc 10 ENTS))
	(setq RETURN (cons (cdr LST) RETURN) ENTS (cdr (member LST ENTS)))
	);while

    
   (if (/= (setq LST (assoc 11 ENTS)) nil)(progn
       (setq RETURN (cons (cdr LST) RETURN) ENTS (cdr (member LST ENTS))))
	     (princ))
     );repeat
  

  (setq X_PISTEET (PISTEEN_LASKIJA_X RETURN));laskee x-suunnan etäisyydet
  (setq Y_PISTEET (PISTEEN_LASKIJA_Y RETURN));laskee y-suunnan etäisyydet
  
;X-suunnan tarkastelu
  
  (setq MITTA_PITUUDET (length X_PISTEET)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI X_PISTEET)
	MÄÄRÄ (list))
  
  (while (< LASKURI MITTA_PITUUDET)
    (if (= (rtos ENSIMMÄINEN) (rtos ANTD))(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI X_PISTEET)));while

  (if (>= (length MÄÄRÄ) 60)(progn
			     (write-line " -Distance of the columns in X-direction is correct  \t1p " TF)
			     (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -Check the distance of columns in X-direction. (From left column to right column)" TF))

;Y-suunnan tarkastelu pilareiden teräslevyliitokselle
  
  (setq MITTA_PITUUDET (length Y_PISTEET)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI Y_PISTEET)
	MÄÄRÄ (list))

  (while (< LASKURI MITTA_PITUUDET)
    (if (= (rtos ENSIMMÄINEN) (rtos 40.0))(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI Y_PISTEET)));while

  (if (>= (length MÄÄRÄ) 14)(progn
			     (write-line " -The lines depicting the columns are cut at the steel plate joint  \t\t\t\t1p " TF)
			     (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -Fix the steel plate joint! The columns should cut at the steel plate joint \t\t\t\t0p" TF))


;Y-suunnan tarkastelu pilareiden teräslevyliitokselle
  
  (setq MITTA_PITUUDET (length Y_PISTEET)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI Y_PISTEET)
	MÄÄRÄ (list))

  (while (< LASKURI MITTA_PITUUDET)
    (if (= (rtos ENSIMMÄINEN) (rtos ANTH))(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI Y_PISTEET)));while

  (if (>= (length MÄÄRÄ) 6)(progn
			     (write-line " -The lowest point of lines depicting columns are at correct level with respect to Y-axis \t1p " TF)
			     (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -The starting points (lowest points) of the columns are not at the correct level with respect to each other " TF))

;pilarin leveys

   (setq MITTA_PITUUDET (length X_PISTEET)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI X_PISTEET)
	MÄÄRÄ (list))
  
  (while (< LASKURI MITTA_PITUUDET)
    (if (= (rtos ENSIMMÄINEN) (rtos PROF_MITTA))(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI X_PISTEET)));while

  (if (>= (length MÄÄRÄ) 60)(progn
			     (write-line " -The width of columns is correct \t1p " TF)
			     (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -Check the width of columns" TF))

  (setq Y_PISTEET nil)
  (setq X_pisteet nil)
  
  (princ RETURN)
  
  );defun

;-------------------------------------------PILARI_ANALYYSI LOPPU-------------------------

;---------------------------------------INFO---------------------------------------------------------
;	SEURAAVAN FUNKTION LOKAALIT MUUTTUJAT:  ---- Nollautuu funktion päätyttyä
;RETURN 	- Palauttaa pilareiden piirustusobjektien pisteet
;SSPITUUS	- Selection setin pituus
;ENTITY & ENTS 	- Selection Setin jäsen (esim yksi viiva) ja sen ominaisuus (esim. linetype)
;X_PISTEET	- Funktion pallauttama lista, jossa pilareiden x-pisteiden etäisyydet
;Y_PISTEET 	- Funktion pallauttama lista, jossa pilareiden y-pisteiden etäisyydet
;MITTA_PITUUDET - Montako mittaa on listassa
;ENSIMMÄINEN 	- Listan ensimmäinen mitta --> kasvaa while loopin mukaisesti
;LASKURI 	- Erilaisten toistojen (looppien) käyttöä varten
;LST 		- Muuttuja, joka sisältää DXF-koodin 10 tiedon eli pisteen esim. (120.50 134.45)
;MÄÄRÄ 		- Muuttuja, joka sisältää oikeiden haluttujen mittojen määrän 

;	SEURAAVAN FUNKTION INPUT
;KATTOSS 	- Kattorakenteiden tason selection set
;WMAX 		- Katon maksimileveys
;KATTO_MAX	- Katon maksimikorkeus
;KATTO_MAX_2	- Katon rakenteiden maksimi (yläraja)
;KATTO_MAX_1	- Katon rakenteiden maksimi (alaraja)
;TF (Text File) - Tiedosto johon kommentit tulostuvat
;-------------------------------------------KATTO_ANALYYSI ALKU---------------------------
(defun KATTO_ANALYYSI (KATTOSS WMAX KATTO_MAX_1 KATTO_MAX_2 TF / RETURN SSPITUUS ENTITY ENTS LASKURI X_PISTEET Y_PISTEET LST MITTA_PITUUDET ENSIMMÄINEN KATTO_MAX)
  (setq RETURN nil)
   
  (repeat (setq SSPITUUS (sslength KATTOSS))
     (setq ENTITY (ssname KATTOSS (setq SSPITUUS (1- SSPITUUS))))
     (setq ENTS (entget ENTITY))
     (while (setq LST (assoc 10 ENTS))
	(setq RETURN (cons (cdr LST) RETURN) ENTS (cdr (member LST ENTS)))
	);while
    (if (/= (setq LST (assoc 11 ENTS)) nil)
	     (setq RETURN (cons (cdr LST) RETURN) ENTS (cdr (member LST ENTS)))
	     (princ));if
    
     );repeat
  

  (setq X_PISTEET (PISTEEN_LASKIJA_X RETURN));laskee x-suunnan etäisyydet
  (setq Y_PISTEET (PISTEEN_LASKIJA_Y RETURN))
  
;Kattorakenteiden max korkeus
  (setq KATTO_MAX (apply 'max Y_pisteet))

  (if (and
	(>= KATTO_MAX KATTO_MAX_1)
	(<= KATTO_MAX KATTO_MAX_2))(progn
				     (write-line " -Total height of the truss is correct \t1p " TF)
				     (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -Total height of the truss is incorrect" TF))
			      
;|äärimitan etsintä
  (setq MITTA_PITUUDET (length X_PISTEET)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI X_PISTEET)
	MÄÄRÄ (list))
  
;oikea määrä mittoja löytynyt x-suunnassa  
  (while (< LASKURI MITTA_PITUUDET)
    (if (= ENSIMMÄINEN WMAX)(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI X_PISTEET)));while

  (if (>= (length MÄÄRÄ) 8)(progn
			    (write-line " -Total width of the truss is correct \t1p " TF)
			    (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -Maximum width of the truss is incorrect" TF))
  (setq X_pisteet nil)
  (setq Y_pisteet nil)
  

  (princ RETURN)|;
  )
; x-suunnan tarkastelun loppu
;--------------------------------------KATTO_ANALYYSI LOPPU-------------------------------

(defun KATTO_ANALYYSI_X (MIDSS_POLYLINE WMAX TF / RETURN SSPITUUS ENTITY ENTS X_PISTEET LST KATTO_MAX)
  (setq RETURN nil)
   
  (repeat (setq SSPITUUS (sslength MIDSS_POLYLINE))
     (setq ENTITY (ssname MIDSS_POLYLINE (setq SSPITUUS (1- SSPITUUS))))
     (setq ENTS (entget ENTITY))
     (while (setq LST (assoc 10 ENTS))
	(setq RETURN (cons (cdr LST) RETURN) ENTS (cdr (member LST ENTS)))
	);while
    (if (/= (setq LST (assoc 11 ENTS)) nil)
	     (setq RETURN (cons (cdr LST) RETURN) ENTS (cdr (member LST ENTS)))
	     (princ));if
    
     );repeat
  

  (setq X_PISTEET (PISTEEN_LASKIJA_X RETURN));laskee x-suunnan etäisyydet
 
  
;Kattorakenteiden max korkeus
  (setq KATTO_MAX (apply 'max X_pisteet))

  (if (= (rtos KATTO_MAX) (rtos WMAX))(progn
			  (write-line " -Total width of the truss is correct (calculated according to the center lines) \t1p " TF)
			  (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -Maximum width of the truss is incorrect (calculated according to the center lines)" TF))

)


;---------------------------------------INFO---------------------------------------------------------
;	SEURAAVAN FUNKTION LOKAALIT MUUTTUJAT:  ---- Nollautuu funktion päätyttyä
;RETURN 	- Palauttaa pilareiden piirustusobjektien pisteet
;SSPITUUS	- Selection setin pituus
;ENTITY & ENTS 	- Selection Setin jäsen (esim yksi viiva) ja sen ominaisuus (esim. linetype)
;X_PISTEET	- Funktion pallauttama lista, jossa pilareiden x-pisteiden etäisyydet
;Y_PISTEET 	- Funktion pallauttama lista, jossa pilareiden y-pisteiden etäisyydet
;MITTA_PITUUDET - Montako mittaa on listassa
;ENSIMMÄINEN 	- Listan ensimmäinen mitta --> kasvaa while loopin mukaisesti
;LASKURI 	- Erilaisten toistojen (looppien) käyttöä varten
;LST 		- Muuttuja, joka sisältää DXF-koodin 10 tiedon eli pisteen esim. (120.50 134.45)
;MÄÄRÄ 		- Muuttuja, joka sisältää oikeiden haluttujen mittojen määrän 

;	SEURAAVAN FUNKTION INPUT
;SLABSS 	- Teräslevyjen tason selection set
;WMAX 		- Katon maksimileveys
;KATTO_MAX	- Katon maksimikorkeus
;KATTO_MAX_2	- Katon rakenteiden maksimi (yläraja)
;KATTO_MAX_1	- Katon rakenteiden maksimi (alaraja)
;TF (Text File) - Tiedosto johon kommentit tulostuvat
;--------------------------------------SLAB_ANALYYSI ALKU---------------------------------
(defun SLAB_ANALYYSI (SLABSS ANTD ANTH PROF_MITTA TF / RETURN SSPITUUS ENTITY ENTS LST LASKURI X_PISTEET Y_PISTEET MITTA_PITUUDET ENSIMMÄINEN MÄÄRÄ)
  (setq RETURN nil)
   
  (if (= (sslength SLABSS) 4)(progn
			       (write-line " -Right number of objects and right drawing tehnique is used (POLYLINE) \t1p" TF)
			       (setq ARVOSANA (1+ ARVOSANA)))
    (write-line " -There is eaither too many or too few objects on STEEL PLATES layer. Remember to use POLYLINE. Check for overlapping objects" TF))
  (repeat (setq SSPITUUS (sslength SLABSS))
     (setq ENTITY (ssname SLABSS (setq SSPITUUS (1- SSPITUUS))))
     (setq ENTS (entget ENTITY))
     (while (setq LST (assoc 10 ENTS))
	(setq RETURN (cons (cdr LST) RETURN) ENTS (cdr (member LST ENTS)))
	);while
     );repeat

  
  (setq X_PISTEET (PISTEEN_LASKIJA_X RETURN));laskee x-suunnan etäisyydet
  (setq Y_PISTEET (PISTEEN_LASKIJA_Y RETURN))

  ;luodaan yhden teräslevyn koon tarkasteluun oma pistelista, josta lasketaan levyn koko


  (setq RETURN2 nil)
  (setq ENITITY (ssname SLABSS 0))
  (setq ENTS (entget ENTITY))
  (while (setq LST (assoc 10 ENTS))
    (setq RETURN2 (cons (cdr LST) RETURN2) ENTS (cdr (member LST ENTS)))
	);while

  (setq X_PISTEET_LEVY (PISTEEN_LASKIJA_X RETURN2))
  (setq Y_PISTEET_LEVY (PISTEEN_LASKIJA_Y RETURN2))

  ;teräslevy koko

   (setq TERÄSLEVYN_LEVEYS (+ PROF_MITTA 60.0))

   (setq MITTA_PITUUDET (length Y_PISTEET_LEVY)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI Y_PISTEET_LEVY)
	MÄÄRÄPAK (list))

  (while (< LASKURI MITTA_PITUUDET)
    (if (= (rtos ENSIMMÄINEN) (rtos 20.0))(setq MÄÄRÄPAK (cons 1 MÄÄRÄPAK))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI Y_PISTEET_LEVY)));while

   (setq MITTA_PITUUDET (length X_PISTEET_LEVY)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI X_PISTEET_LEVY)
	MÄÄRÄLEV (list))
  
  (while (< LASKURI MITTA_PITUUDET)
    (if (= (rtos ENSIMMÄINEN) (rtos TERÄSLEVYN_LEVEYS))(setq MÄÄRÄLEV (cons 1 MÄÄRÄLEV))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI X_PISTEET_LEVY)));while

   (setq LEVYKOKO (+ (length MÄÄRÄLEV) (length MÄÄRÄPAK)))

   (if (>= LEVYKOKO 15)(progn
			 (write-line " -By random inspection, the size of the steel plate is correct \t1p" TF)
			 (setq ARVOSANA (+ ARVOSANA 1)))
      (write-line " -By random inspection, the size of the steel plate is incorrect" TF))

  

;x-suunnassa teräslevyjen tarkastelu
   
  (setq MITTA_PITUUDET (length X_PISTEET)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI X_PISTEET)
	MÄÄRÄ (list))
  
  (while (< LASKURI MITTA_PITUUDET)
    (if (= (rtos ENSIMMÄINEN) (rtos ANTD))(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI X_PISTEET)));while
  
  (if (>= (length MÄÄRÄ) 64)(progn
			     (write-line " -The steel plates of the columns are at the correct distance from each other on the X-axis \t1p" TF)
			     (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -Check the distances of objects on the layer on the X axis" TF))


 
;liitoksen paksuus

    (setq MITTA_PITUUDET (length Y_PISTEET)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI Y_PISTEET)
	MÄÄRÄ (list))

  (while (< LASKURI MITTA_PITUUDET)
    (if (= (rtos ENSIMMÄINEN) (rtos 40.0))(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI Y_PISTEET)));while

  (if (>= (length MÄÄRÄ) 16)(progn
			     (write-line " -The thickness of the steel plate joint is correct \t1p" TF)
			     (setq ARVOSANA (+ ARVOSANA 1))) 
    (write-line " -There is a fault in the steel plate joint" TF))
   
  (setq X_PISTEET nil)
  (setq Y_PISTEET nil)

  (princ RETURN)
  );defun
  
;----------------------------------SLAB_ANALYYSI LOPPU------------------------------------

;---------------------------------------INFO---------------------------------------------------------
;	SEURAAVAN FUNKTION LOKAALIT MUUTTUJAT:  ---- Nollautuu funktion päätyttyä
;MID_ALL 	- Kaikki MID_LINES tason alkiot
;MID_ALL_LEN	- Edellisen pituus
;MID_PL_LEN	- Polyline SS pituus
;ENTITY & ENTS	- Selection Setin jäsen (esim yksi viiva) ja sen ominaisuus (esim. linetype)
;LST		- Muuttuja, joka sisältää DXF-koodin 10 tiedon eli pisteen esim. (120.50 134.45)
;RETURN		- Palauttaa keskilinjojen pisteet

;	SEURAAVAN FUNKTION INPUT
;MIDSS_POLYLINE - Teräslevyjen tason selection set
;TF (Text File) - Tiedosto johon kommentit tulostuvat

;----------------------------------KESKILINJA_ANALYYSI------------------------------------
(defun KESKILINJA_ANALYYSI ( MIDSS_POLYLINE TF / MID_PL_LEN RETURN ENTITY ENTS LST)
  
  (setq MID_PL_LEN (sslength MIDSS_POLYLINE))
  
  (setq RETURN nil)
  (repeat MID_PL_LEN
    (setq ENTITY (ssname MIDSS_POLYLINE (setq MID_PL_LEN (1- MID_PL_LEN))))
     (setq ENTS (entget ENTITY))
     (while (setq LST (assoc 10 ENTS))
	(setq RETURN (cons (cdr LST) RETURN) ENTS (cdr (member LST ENTS)))
	);while
     );repeat


  (princ RETURN)
  )
;--------------------------------KESKILINJA_ANALYYSI--------------------------------------

;---------------------------------------INFO---------------------------------------------------------
;	SEURAAVAN FUNKTION LOKAALIT MUUTTUJAT:  ---- Nollautuu funktion päätyttyä
;SSPITUUS	- Selection setin pituus
;ENTITY & ENTS 	- Selection Setin jäsen (esim yksi viiva) ja sen ominaisuus (esim. linetype)
;LST 		- Muuttuja, joka sisältää DXF-koodin 42 tiedon eli mitoituksen mitan esim. (6000.0)
;RETURN		- Sisältää kaikki mitoitus tiedot
;DIMP		- Mitoituspisteet
;LEVENNYS	- Katon rakenteiden levennys
;MITTA_PITUUDET - Montako mittaa on listassa
;ENSIMMÄINEN 	- Listan ensimmäinen mitta --> kasvaa while loopin mukaisesti
;LASKURI 	- Erilaisten toistojen (looppien) käyttöä varten
;LST 		- Muuttuja, joka sisältää DXF-koodin 10 tiedon eli pisteen esim. (120.50 134.45)
;MÄÄRÄ 		- Muuttuja, joka sisältää oikeiden haluttujen mittojen määrän

;	SEURAAVAN FUNKTION INPUT
;MITTASS 	- Kaikki mitoitus tiedot
;TF (Text File) - Tiedosto johon kommentit tulostuvat
;-------------------------------MITTA_ANALYYSI--------------------------------------------
(defun MITTA_ANALYYSI (MITTASS TF / RETURN SSPITUUS ENTITY ENTS LST LEVENNYS MITTA_PITUUDET LASKURI ENSIMMÄINEN MÄÄRÄ DIMP)
  (setq RETURN nil)
  (repeat (setq SSPITUUS (sslength MITTASS))
     (setq ENTITY (ssname MITTASS (setq SSPITUUS (1- SSPITUUS))))
     (setq ENTS (entget ENTITY))
     (while (setq LST (assoc 42 ENTS))
	(setq RETURN (cons (distof (rtos (cdr LST))) RETURN)
	      ENTS (cdr (member LST ENTS)))
	);while
     );repeat

  (setq DIMP 0
	LEVENNYS 200.0)
  (if (/= (member L1 RETURN) nil)(progn
				    (setq DIMP (+ DIMP 1))
				    (setq ARVOSANA (1+ ARVOSANA))
				    (write-line " -The left chord of the truss is dimensioned correctly \t1p" TF)
				    )
     (setq DIMP (+ DIMP 0))); L1 mitta
   
  (if (/= (member L2 RETURN) nil)(progn
				    (setq DIMP (+ DIMP 1))
				    (setq ARVOSANA (1+ ARVOSANA))
				    (write-line " -The right chord of the truss is dimensioned correctly \t1p" TF))
     (setq DIMP (+ DIMP 0))); L2 mitta
   
  (if (/= (member (- KMAX (/ (+ L1 L2) 8) 765 AK ANTH) RETURN) nil)(progn
								      (setq DIMP (+ DIMP 1))
								      (setq ARVOSANA (1+ ARVOSANA))
								      (write-line " -The dimension of the lower side between the lower chord and the pedestal is correct \t1p" TF))
     (setq DIMP (+ DIMP 0))) ;lyhyemmän sivun mitta (KORKEUS-RISTIKON KORK-765-Anturan korkeus-Anturoiden välinen etäisyys)
   
  (if (/= (member (- KMAX (/ (+ L1 L2) 8) 765 AK) RETURN) nil)(progn
								 (setq DIMP (+ DIMP 1))
								 (setq ARVOSANA (1+ ARVOSANA))
								 (write-line " -The dimension of the higher side between the lower chord and the pedestal is correct \t1p" TF))
     (setq DIMP (+ DIMP 0))) ;korkeamman sivun mitta (KORKEUS-RISTIKON KORK-765-Anturan korkeus)
   
  (if (/= (member (/ (+ L1 L2) 8) RETURN) nil)(progn
						 (setq DIMP (+ DIMP 1))
						 (setq ARVOSANA (1+ ARVOSANA))
						 (write-line " -The height of the truss is dimensioned correctly\t1p" TF))
     (setq DIMP (+ DIMP 0)));ristikon korkeus

 ;ristikon levennys
  (setq MITTA_PITUUDET (length RETURN)
	LASKURI 0
	ENSIMMÄINEN(nth LASKURI RETURN)
	MÄÄRÄ (list))

   
  (while (< LASKURI MITTA_PITUUDET)
    (if (= ENSIMMÄINEN 200.0)(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI RETURN)));while

  (if (= (length MÄÄRÄ) 2)(progn
			     (setq DIMP (+ DIMP 1))
			     (setq ARVOSANA (1+ ARVOSANA))
			     (write-line " -Widening of the truss is dimensioned correctly \t1p" TF))
     (setq DIMP (+ DIMP 0)))

;perusjalan korkeus

  (setq MITTA_PITUUDET (length RETURN)
	LASKURI 0
	ENSIMMÄINEN(nth LASKURI RETURN)
	MÄÄRÄ (list))

   (while (< LASKURI MITTA_PITUUDET)
    (if (= ENSIMMÄINEN 765.0)(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI RETURN)));while

  (if (= (length MÄÄRÄ) 2)(progn
			     (setq DIMP (+ DIMP 1))
			     (setq ARVOSANA (1+ ARVOSANA))
			     (write-line " -The pedestal is dimensioned correctly \t1p" TF))
     (setq DIMP (+ DIMP 0)))

;teräslevyliitos - ristikon keskilinjan tuki 270 mm   

  (setq MITTA_PITUUDET (length RETURN)
	LASKURI 0
	ENSIMMÄINEN(nth LASKURI RETURN)
	MÄÄRÄ (list))
  
  (while (< LASKURI MITTA_PITUUDET)
    (if (= ENSIMMÄINEN 270.0)(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI)
	  ENSIMMÄINEN (nth LASKURI RETURN)));while

  (if (= (length MÄÄRÄ) 2)(progn
			     (setq DIMP (+ DIMP 1))
			     (setq ARVOSANA (1+ ARVOSANA))
			     (write-line " -The dimension between steel plate joint and column truss joint is correct \t1p " TF))
     (setq DIMP (+ DIMP 0)))

  (if (>= DIMP 8)(progn
		  (write-line " -All checked dimensions are correct" TF)
		  )
    (write-line " -There are still shortcomings in the checked dimensions. Remember that independent changing of dimensions is not permitted" TF))

 
)
;-------------------------------MITTA_ANALYYSI--------------------------------------------

;---------------------------------INFO---------------------------------------------------
;	SEURAAVAN FUNKTION LOKAALIT MUUTTUJAT; -----------> Nollautuu funktion päättyttyä
;;MITTA_PITUUDET - Montako mittaa on listassa
;ENSIMMÄINEN 	- Listan ensimmäinen mitta --> kasvaa while loopin mukaisesti
;LASKURI 	- Erilaisten toistojen (looppien) käyttöä varten
;MÄÄRÄ 		- Muuttuja, joka sisältää oikeiden haluttujen mittojen määrän

;	FUNKTION INPUT TIEDOT;
;XMAX 		- Piirustuksen levein mitta (anturoiden ulkoreunojen etäisyyd
;PITUUDET	- Anturat rakenteiden pituudet
;TF (Text File) - Tiedosto johon kommentit tulostuvat
;--------------------------------MAKSIMI_ANALYYSI_X ALKU----------------------------------

(defun MAKSIMI_ANALYYSI_X (XMAX PITUUDET TF / MITTA_PITUUDET LASKURI ENSIMMÄINEN MÄÄRÄ)
  (setq MITTA_PITUUDET (length PITUUDET)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI PITUUDET)
	MÄÄRÄ (list))
  
  (while (< LASKURI MITTA_PITUUDET)
    (if (= (rtos ENSIMMÄINEN) (rtos XMAX))(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASKURI (1+ LASKURI))
    (setq ENSIMMÄINEN (nth LASKURI PITUUDET)));while

  (if (> (length MÄÄRÄ) 4)(progn
			    (write-line " -Maximum distance in the X-direction is correct \t1p" TF)
			    (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -Maximum distance in the X-direction is distance between outer edges of foundations. Check that this is correct " TF))
  (princ)
  );defun



;-----------------------------MAKSIMI_ANALYYSI_X LOPPU------------------------------------

;---------------------------------INFO---------------------------------------------------
;	SEURAAVAN FUNKTION LOKAALIT MUUTTUJAT; -----------> Nollautuu funktion päättyttyä
;;MITTA_PITUUDET - Montako mittaa on listassa
;ENSIMMÄINEN 	- Listan ensimmäinen mitta --> kasvaa while loopin mukaisesti
;LASKURI 	- Erilaisten toistojen (looppien) käyttöä varten
;MÄÄRÄ 		- Muuttuja, joka sisältää oikeiden haluttujen mittojen määrän
;MID_Y		- Keskilinjojen y pisteet
;ANT_Y		- Anturoiden y-pisteet
;MITAT		- Keskilinjojen ja anturoiden y-suunnan mitat
;LASKU		- Toistojen käyttöä varten
;LENIY		- Keskilinjojen y-pisteiden mitat
;TOINEN		- While loopin avuksi
;J		- Lasku muuttuja vähennyksessä
;LENT		- Anturoiden y-pisteiden määrä
;LASK		- Etäisyyksien etsintä looppiin


;	FUNKTION INPUT TIEDOT;
;MID_P		- Keskilinjojen pisteet
;ANT_P		- Anturoiden pisteet
;AAD 		- Anturan ja alapaarteen keskilinjan etäisyys
;TF (Text File) - Tiedosto johon kommentit tulostuvat
;-----------------------------VAPAAN KORKEUDEN TARKISTUS----------------------------------
(defun VAPAAKORKEUS (MID_P ANT_P AAD TF / MID_Y ANT_Y MITAT LASKURI ENSIMMÄINEN LASKU LENIY TOINEN J LASK MITTA_PITUUDET MÄÄRÄ)
  (setq MID_Y (PARSI_Y MID_P))
  (setq ANT_Y (PARSI_Y ANT_P))

  (setq MITAT (list)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI ANT_Y))
  (repeat (setq LENT (length ANT_Y))
    (setq LASKU 0
	  LENIY (length MID_Y)
	  TOINEN (nth LASKU MID_Y))
    (while (< LASKU LENIY)
      (setq j (- ENSIMMÄINEN TOINEN)
	    j (abs j)
	    MITAT (cons j MITAT)
	    LASKU (1+ LASKU)
	    TOINEN (nth LASKU MID_Y)));while
    (setq LASKURI (1+ LASKURI)
	  ENSIMMÄINEN (nth LASKURI ANT_Y)));repeat

  (setq MITTA_PITUUDET (length MITAT)
	LASK 0
	ENSIMMÄINEN (nth LASK MITAT)
	MÄÄRÄ (list))
  
  (while (< LASK MITTA_PITUUDET)
    (if (= (rtos ENSIMMÄINEN) (rtos AAD))(setq MÄÄRÄ (cons 1 MÄÄRÄ))(setq a 0))
    (setq LASK (1+ LASK))
    (setq ENSIMMÄINEN (nth LASK MITAT)));while

  (if (>= (length MÄÄRÄ) 4)(progn
			     (write-line " -Clearance height of the hall is correct \t1p" TF)
			     (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -Clearance height of the hall is incorrect. Clearance height means the distance between upper surface of the higher foundation and the center line of the lower chord " TF))
  (princ MITAT)
  )

;-------------------------------VAPAAN KOREKUDEN TARKISTUS--------------------------------










;-------------------------------RELAATIOT_1-----------------------------------------------;Anturat,pilarit ja perusjalat
(defun RELAATIOT_1 (ANT_P PJ_P PIL_P TF ANTH AK / X1 X2 X3 Y1 Y2 Y3  LASKURI ENSIMMÄINEN LENX LASKURI_2 LENXX TOINEN A PITUUS MÄÄRÄ_2 MÄÄRÄ_12 MITAT2 MITAT2)
  (setq X1 (PARSI_X ANT_P) ;Anturoiden x-pisteet
	Y1 (PARSI_Y ANT_P) ;Anturoiden y-pisteet
	X2 (PARSI_X PJ_P)  ;Perusjalkojen x-pistee
	Y2 (PARSI_Y PJ_P)  ;Perusjalkojen y-pisteet
	X3 (PARSI_X PIL_P) ;Pilareiden x-pisteet
	Y3 (PARSI_Y PIL_P));Pilareiden y-pisteet

;Anturoiden ja perusjalkojen relaatiot Y-suuntaan

  (setq MITAT12 nil
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI Y1))
  
  (repeat (setq LENX (length Y1))
    (setq LASKURI_2 0
	  LENXX (length Y2)
	  TOINEN (nth LASKURI_2 Y2))
    (while (< LASKURI_2 LENXX)
      (setq A (- ENSIMMÄINEN TOINEN)
	    A (abs A)
	    MITAT12 (cons A MITAT12)
	    LASKURI_2 (1+ LASKURI_2)
	    TOINEN (nth LASKURI_2 Y2)));while
    (setq LASKURI (1+ LASKURI)
	  ENSIMMÄINEN (nth LASKURI Y1)));repeat

  (setq PITUUS (length MITAT12)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI MITAT12)
	MÄÄRÄ_12 (list))
  (while (< LASKURI PITUUS)
    (if (= (rtos ENSIMMÄINEN) (rtos ANTH))(setq MÄÄRÄ_12 (cons 1 MÄÄRÄ_12))(setq A 0))
    (setq LASKURI (1+ LASKURI)
	  ENSIMMÄINEN (nth LASKURI MITAT12)));while

  
  (if (= (rtos ANTH) (rtos 0.0))(progn
				  (if (= (length MÄÄRÄ_12) 8)(progn
							       (write-line " -Footings and pedestals are at a correct distance between each other in the Y-direction \t1p" TF)
			    					(setq ARVOSANA (1+ ARVOSANA)))
				    (write-line " -Footings and pedestals are at incorrect distance between each other in the Y-direction. Distance between lower surface of the footing and basepoint of the pedestal " TF)))
    (princ))
    
  (if (/= (rtos ANTH) (rtos 0.0))(progn
				   (if (= (length MÄÄRÄ_12) 4)(progn
			    					(write-line " -Footings and pedestals are at a correct distance between each other in the Y-direction \t1p" TF)
			    					(setq ARVOSANA (1+ ARVOSANA)))
				     (write-line " -Footings and pedestals are at incorrect distance between each other in the Y-direction. Distance between lower surface of the footing and basepoint of the pedestal " TF)))
    (princ))



    
;Anturoiden ja pilareiden relaatiot Y-suuntaan

  (setq MITAT2 nil
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI Y1))
  (repeat (setq LENX (length Y1))
    (setq LASKURI_2 0
	  LENXX (length Y3)
	  TOINEN (nth LASKURI_2 Y3))
    (while (< LASKURI_2 LENXX)
      (setq A (- ENSIMMÄINEN TOINEN)
	    A (abs A)
	    MITAT2 (cons A MITAT2)
	    LASKURI_2 (1+ LASKURI_2)
	    TOINEN (nth LASKURI_2 Y3)));while
    (setq LASKURI (1+ LASKURI)
	  ENSIMMÄINEN (nth LASKURI Y1)));repeat

  (setq PITUUS (length MITAT2)
	LASKURI 0
	ENSIMMÄINEN (nth LASKURI MITAT2)
	MÄÄRÄ_2 (list))
  (while (< LASKURI PITUUS)
    (if (or
	  (= (rtos ENSIMMÄINEN) (rtos 765.0))
	  (= (rtos ENSIMMÄINEN) (rtos 800.0)))(setq MÄÄRÄ_2 (cons 1 MÄÄRÄ_2))(setq A 0))
    (setq LASKURI (1+ LASKURI)
	  ENSIMMÄINEN (nth LASKURI MITAT2)));while


  (if (= (rtos ANTH) (rtos 0.0))(progn
				  (if (= (length MÄÄRÄ_2) 16)(progn
							       (write-line " -Footings and columns are at correct distance to each other in Y-direction. Lowest points of the column - upper surface of footing \t1p" TF)
			    					(setq ARVOSANA (1+ ARVOSANA)))
				    (write-line " -Footings and columns are at incorrect distance to each other in Y-direction. Lowest points of the column - upper surface of footing" TF)))
    (princ))
    
  (if (/= (rtos ANTH) (rtos 0.0))(progn
				   (if (= (length MÄÄRÄ_2) 8)(progn
			    					(write-line " -Footings and columns are at correct distance to each other in Y-direction. Lowest points of the column - upper surface of footing \t1p" TF)
			    					(setq ARVOSANA (1+ ARVOSANA)))
				     (write-line " -Footings and columns are at incorrect distance to each other in Y-direction. Lowest points of the column - upper surface of footing " TF)))
    (princ))
			    

   
  )
;-------------------------------RELAATIOT_1-----------------------------------------------

;------------------------------RASTEROINTI ALKAA-----------------------------------------

(defun RASTEROINTI_ANALYYSI (RASTEROINTISS NRO / LISTA_V LISTA_T LASKURI EKA VÄRI TYYLI EKA_T LISTA_O RMAX RMIN)
  (setq OIKEIN 0)
  (setq LISTA_V nil
	LISTA_T nil
	LASKURI 0)
  (repeat (sslength RASTEROINTISS)
    (setq EKA (entget (ssname RASTEROINTISS LASKURI))
	  VÄRI (cdr (assoc 62 EKA))
	  TYYLI ( cdr (assoc 2 EKA))
	  LISTA_V (cons VÄRI LISTA_V)
	  LISTA_T (cons TYYLI LISTA_T)
	  LASKURI (1+ LASKURI))
	  )
  (setq LASKURI 0
	LISTA_O nil)
  (repeat (length LISTA_V)
    (setq EKA (nth LASKURI LISTA_V))
    (setq EKA_T (nth LASKURI LISTA_T))
    (if (= EKA 99)(setq LISTA_O (cons 1 LISTA_O))
      (setq LISTA_O (cons 0 LISTA_O)))
    (if (= EKA_T "SOLID")(setq LISTA_O (cons 1 LISTA_O))
      (setq LISTA_O (cons 0 LISTA_O)))
    (setq LASKURI (1+ LASKURI))
    )

  (setq RMAX (apply 'max LISTA_O)
	RMIN (apply 'min LISTA_O))
  (if (and
	(= RMAX 1)
	(= RMIN 1))(progn
		     (write-line " -Rasterization is done with correct color and pattern \t1p" TF)
		     (setq ARVOSANA (1+ ARVOSANA)))
    (write-line " -The color or/and pattern of the rasterization is incorrect" TF))
  (princ)
  )

;-------------------------------PÄÄFUNKTIO ALKAAA-----------------------------------------
(defun c:AC2(/ )
  
  (setq NIMI (getvar "DWGNAME")  ;otetaan tiedostonimestä kuusi ensimmäistä numeroa, joiden avulla haemme parametriexcelistä tiedot
	NIMIT (substr NIMI 1 6)
	TIEDOSTONIMI (strcat NIMIT ".csv")
	ASE (findfile TIEDOSTONIMI)
	TIEDOSTO (open ASE "r")
	RIVI (read-line TIEDOSTO)
	PITUUS (strlen RIVI)
	LISTA1 (list))

 
  (setq TF (getfiled "Filename" "" "txt" 1))
  (setq TF (open TF "w"))
  
  (write-line "Checker for AutoCAD Industrial Hall's cross section in ENG-A2001 Computer-aided tools in engineering course\nProgram inspects various features of the drawing, such as dimensions and drawing tehcniques." TF)
  (write-line "Program also inspects the use of layers and monitors the number of drawing objects on certain layers" TF)
  (write-line "----------------------------------------------------------------------------------------------" TF)


  (setq OPISKELIJANUMERO (substr RIVI 1 6))
  (setq RIVI (PARSIJA RIVI))
  (setq LISTA1 (cons RIVI LISTA1))
  (setq OP (nth 0 LISTA1));listassa vain yksi opiskelijatunnus ja parametrit, ensimmäisenä tarkastttavan opiskelijan tiedot
  
  
  
  (close TIEDOSTO);suljetaan excel tiedosto
 

  (if (= OPISKELIJANUMERO NIMIT)(write-line "Correct parameters were found" TF) ;jos piirustuksen nimi ei ole oikein, lopettaa koko tarkistuksen, sillä oikeita arvoja ei täten löydy
    (progn
       (write-line "There is something wrong with the filename" TF)
       (exit)))

  
  (setq PRSTR (strcat "Student ID: " OPISKELIJANUMERO))
  (write-line PRSTR TF)
  (write-line "----------------------------------------------------------------------------------------------" TF)
   (write-line "Evaluation of the drawing below (Total points can be found at the end of the document):" TF)
   (write-line "----------------------------------------------------------------------------------------------" TF)

  
	
  (setq TULOS 0);lopulliset pisteet tehtävästä
  (setq ARVOSANA 0)
  (setq ARVOSANA_VAL 0)
  (setq TASO_PISTEET 0);tasojen löytymisen ja asetuksien pisteet
  (setq MÄÄRÄ_MITTA 0);tasoilta löytyvien alkioiden pisteet
  (setq VALINNAISET 0);valinnaiset pisteet (eivät rajoita läpipääsyä)
	     
;|Ollaan saatu oikean opiskelijan tiedot tallennettua OP muuttujaan
ja muuttujan alla olevista tiedoista saadaan irti seuraavat:
1.	Opiskelijanumero
2-3.	Ristikoiden etäisyydet, eli nöiden yhteenlaskusta saadaan esim. Anturoiden, perusjalkojen ja pilareiden etäisyydet
4.	Vapaa korkeus jonka yhteyttä malli piirustuksiin en osaa sanoa
5-6.	Näiden erotus antaa anturoiden, perusjalkojen korkeusasemien erotuksen
7.	Ristikon kaltevuus
8.	Anturan leveys
9. 	Anturan syvyys
10.	Anturan korkeus
18.	Alapaarteen leveys
|;
  (setq L1 (nth 1 OP);Vasen jänne  
      	L2 (nth 2 OP);Oikea jänne
      	VK (nth 3 OP) ;Vapaa korkeus 
      	VASK (nth 4 OP);Vasen antura korko
      	OIKK (nth 5 OP);Oikea antura korko
      	KALT (nth 6 OP);Katon kaltevuus
      	AL (nth 7 OP);Anturan leveys
      	AK (nth 9 OP);Anturan korkeus
	ALAK (nth 18 OP))
  
  (setq ANTD (+ L1 L2);Anturoiden,pilareiden etäisyys
	WMAX (+ L1 L2 400);Kattorakenteiden leveys
	PROF (/ ALAK 2);Alapaarteen keskilinja
	AAD (+ 765 -265 PROF VK);Anturan ja alapaarteen keskilinjan etäisyys
	ANTH (abs (- VASK OIKK));Anturoiden korko ero
	KMAX (+ (/ ANTD 8) AAD ANTH AK);Korkeusmaksimi
	PROF (nth 15 OP);HEA Profiili
	ALAPAARRE (nth 17 OP));Alapaarteen koko
  

  (setq KATTO_MAX_1 (+ (/ ANTD 8) ALAPAARRE));kattorakenteiden max korkeus (alaraja)
  (setq KATTO_MAX_2(+ (/ ANTD 8) ALAPAARRE 5));kattorakenteiden max korkeus (yläraja)
	
  (setq IKKUNA_HALLI '((-2500 -2500)(-2500 17500)(17500 17500)(17500 -2500)));piirtoikkuna 1 hallin poikkileikkaukselle
  (setq IKKUNA_DET1 '((-2500 -7500)(-2500 -2500)(2500 -2500)(2500 -7500))); piirtoikkuna 1 detaljille
  (setq IKKUNA_DET2 '((2500 -7500)(2500 -2500)(7500 -2500)(7500 -7500))); piirtoikkuna 2 detaljille


  (setq PROFIILIT '((100.0 96.0)(120.0 114.0)(160.0 152.0)(200.0 190.0)(300.0 290.0)(250.0 240.0)));HEA Profiili lista

  
;Oikea piirustuspohja tarkastetaan

  (setq POHJASS (ssget "X" '((8 . "RAJA_ALUEET")(0 . "MTEXT")(1 . "2019"))))
  (if (/= POHJASS nil)(progn
			(setq POHJAPP 0
			      LUKU (entget (ssname POHJASS 0))
			      LUKU (assoc 10 LUKU)
			      Y_LUKU (nth 2 LUKU)
			      X_LUKU (nth 1 LUKU))
			(if (= Y_LUKU -10000)(setq POHJAPP (1+ POHJAPP))
			  (princ))
			(if (= X_LUKU -10000)(setq POHJAPP (1+ POHJAPP))
			  (princ))
			(if (= POHJAPP 2)(progn
					   (setq ARVOSANA (+ ARVOSANA 2))
					   
					   (write-line "\nCorrect template is being used \t2p" TF))
			   (write-line "\nFault in the template" TF))
			);progn
    (write-line "\nWrong template" TF));if

  (setq POHJASS nil
	POHJAPP nil
	LUKU nil
	Y_LUKU nil
	X_LUKU nil
	)

;ANTURAT-----------------------------------------------------------------------------------------------------------------------------------------------------------------

  (setq RELA 0)
  (setq ANTURATASO (tblsearch "LAYER" "FOOTINGS"))
  (if (/= ANTURATASO nil) (progn
			  (write-line "\n\tFootings:" TF)
			  (write-line " -FOOTINGS layer found" TF)
			  (setq ANTURASS (ssget "_WP" IKKUNA_HALLI '((8 . "FOOTINGS")(0 . "LWPOLYLINE"))))
			  (setq TASO_PISTEET (+ TASO_PISTEET 1))
			  )
    
    (write-line "\n -FOOTINGS layer not found" TF))

    (if (/= ANTURASS nil)(progn
			   (setq ANT_P (ANTURA_ANALYYSI ANTURASS ANTD ANTH AL AK TF))
			   (setq ANTURA_ALAPAARRE nil)
			   (setq ANTURA_ALAPAARRE (cons 1 ANTURA_ALAPAARRE))
			   (setq RELA (1+ RELA)))
      (write-line " -There is no obejcts on FOOTINGS layer." TF))

									    
;PERUSJALAT-----------------------------------------------------------------------------------------------------------------------------------------------------------------

  
  (setq PERUSJALKATASO (tblsearch "LAYER" "PEDESTALS"))
  (if (/= PERUSJALKATASO nil) (progn
				(write-line "\n\tPedestals:" TF)
			  (write-line " -PEDSTALS layer found" TF)
			  (setq PERUSJALKASS (ssget "_WP" IKKUNA_HALLI '((8 . "PEDESTALS")(0 . "INSERT"))))
			  (setq TASO_PISTEET (1+ TASO_PISTEET)))
    (write-line "\n -PEDSTALS layer not found" TF))

  (if (/= PERUSJALKASS nil)(progn
			     (setq PJ_P (PERUSJALKA_ANALYYSI PERUSJALKASS ANTD ANTH TF))
			     (setq RELA (1+ RELA)))
    (write-line " -There is no objects on PEDESTALS layer" TF))

;PILARIT-----------------------------------------------------------------------------------------------------------------------------------------------------------------

  (setq LASKURI 0)
  (setq EKAS (car (nth LASKURI PROFIILIT)))
  (repeat (length PROFIILIT)
    (if (= PROF (distof (rtos EKAS) 2))(setq PROF_MITTA (cdr (nth LASKURI PROFIILIT)))
      (progn
	(setq LASKURI (1+ LASKURI)
	      EKAS (car (nth LASKURI PROFIILIT))))))

  (setq PROF_MITTA (car PROF_MITTA))

  
  (setq PILARITASO (tblsearch "LAYER" "STEEL COLUMNS"))
  (if (/= PILARITASO nil) (progn
			    (write-line "\n\tColumns:" TF)
			  (write-line " -STEEL COLUMNS layer found" TF)
			  (setq PILARISS (ssget "_WP" IKKUNA_HALLI '((8 . "STEEL COLUMNS"))))
			  (setq TASO_PISTEET (1+ TASO_PISTEET)))
    (write-line "\n -STEEL COLUMNS layer not found" TF))

  (if (/= PILARISS nil)(progn
			 (setq PIL_P (PILARI_ANALYYSI PILARISS ANTD ANTH PROF_MITTA TF))
			 (setq RELA (1+ RELA)))
    (write-line " -There is no objects on STEEL COLUMNS layer" TF))

;KESKILINJAT-----------------------------------------------------------------------------------------------------------------------------------------------------------------
  (setq MIDTASO (tblsearch "LAYER" "CENTER LINES"))
  (if (/= MIDTASO nil) (progn
			 (write-line "\n\tCenter lines:" TF)
			 (write-line " -CENTER LINES layer found" TF)
			 (setq MIDSS_POLYLINE (ssget "_WP" IKKUNA_HALLI '((8 . "CENTER LINES"))))
			 (setq TASO_PISTEET (1+ TASO_PISTEET))
			 (setq LINETYPE (assoc 6 MIDTASO))
			 (setq LINETYPE (cdr LINETYPE))
			 (if (= LINETYPE "ACAD_ISO11W100")(progn
							    (write-line " -Right linetype (ACAD_ISO11W100) is used in the drawing \t\t1p optional" TF)
							    (setq ARVOSANA (+ ARVOSANA 1)))
			   (write-line " -Download the right linetype for CENTER LINES layer" TF)))
    (write-line "\n -CENTER LINES layer not found" TF))

  (if (/= MIDSS_POLYLINE nil)(progn
			       (setq MID_P (KESKILINJA_ANALYYSI MIDSS_POLYLINE TF))
			       (setq ANTURA_ALAPAARRE (cons 1 ANTURA_ALAPAARRE)))
    (write-line " -There is no objects on CENTER LINES layer" TF))
  
;KATTORAKENTEET-----------------------------------------------------------------------------------------------------------------------------------------------------------------
  
  
  (setq KATTOTASO (tblsearch "LAYER" "TRUSS"))
  (if (/= KATTOTASO nil) (progn
			   (write-line "\n\tRoof structure:" TF)
			  (write-line " -TRUSS layer found" TF)
			  (setq KATTOSS (ssget "_WP" IKKUNA_HALLI '((8 . "TRUSS"))))
			  (setq TASO_PISTEET (1+ TASO_PISTEET)))
    (write-line "\n -TRUSS layer not found" TF))

  (if (/= KATTOSS nil)(setq KAT_P (KATTO_ANALYYSI KATTOSS WMAX KATTO_MAX_1 KATTO_MAX_2 TF))(write-line " -There is no objects on TRUSS layer." TF))

  (if (/= MID_P nil)(setq KAT_P_X (KATTO_ANALYYSI_X MIDSS_POLYLINE WMAX TF))(setq a 0))

;SLABIT -----------------------------------------------------------------------------------------------------------------------------------------------------------------

  
  (setq SLABTASO (tblsearch "LAYER" "STEEL PLATES"))
  (if (/= SLABTASO nil) (progn
			  (write-line "\n\tSteel plates of the columns:" TF)
			  (write-line " -STEEL PLATES layer found" TF)
			  (setq SLABSS (ssget "_WP" IKKUNA_HALLI '((8 . "STEEL PLATES"))))
			  (setq TASO_PISTEET (1+ TASO_PISTEET)))
    (write-line "\n -STEEL PLATES layer not found" TF))

  (if (/= SLABSS nil)(setq SLAB_P (SLAB_ANALYYSI SLABSS ANTD ANTH PROF_MITTA TF))(write-line " -There is no objects on STEEL PLATES layer." TF))



;Mitoitus-----------------------------------------------------------------------------------------------------------------------------------------------------------------
  (setq MITTATASO (tblsearch "LAYER" "DIMENSIONS"))
  (if (/= MITTATASO nil) (progn
			   (write-line "\n\tDimensions:" TF)
			 (write-line " -DIMENSIONS layer found" TF)
			 (setq MITTASS (ssget "_WP" IKKUNA_HALLI '((8 . "DIMENSIONS"))))
			 (setq TASO_PISTEET (1+ TASO_PISTEET)))
    (write-line "\n -DIMENSIONS layer not found" TF))

  (if (/= MITTASS nil)(setq MITTA_P (MITTA_ANALYYSI MITTASS TF))(write-line " -There is no objects on DIMENSIONS layer" TF))


;Anturan, perusjalan ja pilareiden -----------------------------------------------------------------------------------------------------------------------------------------------------------------


   (write-line "\n\tRELATIONS:" TF)

   (if (= RELA 3)(progn
		  (setq ANT_PJ_PIL (RELAATIOT_1 ANT_P PJ_P PIL_P TF ANTH AK)))
    (princ))

 

;ALAPAARRE VS ANTURA-----------------------------------------------------------------------------------------------------------------------------------------------------------------

  (if (= (length ANTURA_ALAPAARRE) 2)(setq VK_TARKISTUS (VAPAAKORKEUS MID_P ANT_P AAD TF))(setq a 0))

;PIIRUSTUKSEN ÄÄRIMITAT X_AKSELILLA-----------------------------------------------------------------------------------------------------------------------------------------------------------------

  
  (if (/= ANT_P NIL)(progn
		      (setq XMAX (+ ANTD AL))
		      (setq AX 1)
		      (setq X_PISTEETMAX (PISTEEN_LASKIJA_X ANT_P))
		      (setq SAATU_MAKSIMITX (MAKSIMI_ANALYYSI_X XMAX X_PISTEETMAX TF)))
    (write-line " -Extremities can not be checked yet!" TF))

;Piirustuksen äärimitat Y-akselilla-----------------------------------------------------------------------------------------------------------------------------------------------------------------
  (setq YMAX 0)
  (setq YMAX (apply 'max VK_TARKISTUS)) ;VK_TARKISTUS lista sisältää kaikki mitat ANTUROIDEN ja KESKILINOJEN välillä, siellä on myös siis piirustuksen maksimi korkeus


 (if (= (rtos YMAX) (rtos KMAX))(progn
		     (write-line " -Maximum height of the drawing is correct in the Y-direction \t1p" TF)
		     (setq ARVOSANA (+ ARVOSANA 1)))
    (write-line " -Height of the drawing is incorrect. Total height is calculated from lower surface of the foundation to highest point of the truss (upper chords' intersection)" TF))
;OTSIKOT------------------------------------------------------------------------------------------------------------------
  (setq OTSIKKOTASO (tblsearch "LAYER" "TITLES"))
  (if (/= OTSIKKOTASO nil)(progn
			    (write-line "\n\tTITLES:" TF)
			    (write-line " -TITLES layer found." TF)
			    (setq OTSIKKOSS (ssget "_WP" IKKUNA_HALLI '((8 . "TITLES"))))
			    (setq TASO_PISTEET (1+ TASO_PISTEET)))
    (write-line " -Create TITLES layer and place the title of section and details on it." TF))


;tekstit tason asetukset, pistokoe tekstikorkeudesta
   (setq TEKSTITTASO (tblsearch "LAYER" "TEXTS"))
   (if (/= TEKSTITTASO nil)(progn
			    (write-line "\n\tTEXTS:" TF)
			    (write-line " -TEXTS layer found." TF)
			    (setq TEKSTITSS (ssget "x" '((8 . "TEXTS")(0 . "MTEXT"))))
			    (setq TASO_PISTEET (1+ TASO_PISTEET)))
    (write-line " -TEXTS layer not found. Create a layer and place all of the texts on it." TF))
		
   					  
;rasterointi
(write-line "\n\tLayers and rasterization:" TF)

  (setq RASTEROINTISS (ssget "x" '((0 . "HATCH"))))
  (if (/= RASTEROINTISS nil)(progn
			      (setq RAST_V (RASTEROINTI_ANALYYSI RASTEROINTISS NRO)))
    (write-line " -There is no rasterization in the drawing" TF))

;muut tasot
   
   (if (= TASO_PISTEET 9)(progn
			   (setq ARVOSANA (+ ARVOSANA 5))
			   (write-line " -Layers are correctly created \t5p" TF ))
     (write-line " -Layers missing from the drawing" TF))
   

; kasataan tulokset
  (write-line "\n\tRESULTS:" TF)

  

;kirjataan tulos teksti tiedostoon ja excel taulukkoon
  (setq PRSTR (strcat "Checker's points: "(itoa ARVOSANA)"/41 points"))
  (write-line PRSTR TF)
 


   
;LOPPUTOIMET
  ;Sulkee TF tiedoston
  (close TF)
   
;------------------------------------
  (setq RELA nil
	TULOS nil
	ANTURA_ALAPAARRE nil)
	;VK_TARKISTUS nil;)
  
  (princ)
  );defun


