;--------------- DECLARACION DE MACROS ---------
include macros.asm

.model small
;--------------- SEGMENTO DE PILA ---------------
.stack 64
;--------------- SEGMENTO DE DATO ---------------
.data
    msj db 0ah,0dh, 'Hola Mundo','$'
    txt_header  db 	'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA',13,10
				db	'FACULTAD DE INGENIERIA',13.10
				db	'CIENCIAS Y SISTEMAS',13,10
				db	'ARQUITECTURA DE COMPUTADORAS Y ENSAMBLADORES 1',13,10
				db	'NOMBRE: JOSE DANIEL LOPEZ GONZALEZ',13,10
				db	'CARNET: 201503836',13,10
				db	'SECCION: A',13,10,' $'

    txt_menu		db	' ',13,10
				db	'|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|',13,10
				db	'|%%%%%%%%%%%%%% MENU %%%%%%%%%%%%%%|',13,10
				db	'|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|',13,10
				db	'|%%%|                          |%%%|',13,10
				db	'|%%%|	1- INICIAR JUEGO       |%%%|',13,10
				db	'|%%%|	2- CARGAR JUEGO        |%%%|',13,10
				db	'|%%%|	3- SALIR               |%%%|',13,10
				db	'|%%%|                          |%%%|',13,10
				db	'|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|',13,10
				db	' ',13,10
				db	'| > presione un numero: $',13,10

    txt_jugar   db	' ',13,10
				db 	'|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|',13,10
                db  '|%%%%%%%%%% JUEGO  NUEVO %%%%%%%%%%|',13,10   
                db	'|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|','$'
    txt_cargar_juego    db	' ',13,10
						db '|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|',13,10
                        db  '|%%%%%%%%%% CARGAR JUEGO %%%%%%%%%%|',13,10   
                        db	'|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|','$'    
	txt_fin   	db	' ',13,10
				db 	'|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|',13,10
                db  '|%%%%%%%%%% FIN DE JUEGO %%%%%%%%%%|',13,10   
                db	'|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|','$'
	txt_win_b  	db	' ',13,10
                db  '|%%%%%%%% GANADOR  BLANCAS %%%%%%%%|',13,10   
                db	'|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|','$'
	txt_win_n  	db	' ',13,10
                db  '|%%%%%%%%% GANADOR NEGRAS %%%%%%%%%|',13,10   
                db	'|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|','$'					

	txt_salto	db 	13,10, '$'
	txt_rutaIn	db	'| > Inserte una ruta con extension .arq',13,10
				db	'| - Ejemplo: /archivo.arq',10,13,'$'
    txt_turnoA  db	' ',13,10
				db  '| > Inserte un comando',13,10
                db  '| > Turno Negras: $'
    txt_turnoB  db	' ',13,10
				db  '| > Inserte un comando',13,10
                db  '| > Turno Blancas: $' 
	txt_error	db	'| ** Error: [01]',13,10
				db	'| - Comando o coordenada incorrectas',10,13,'$'
	txt_error2	db	'| ** Error: [02]',13,10
				db	'| - Coordenada no disponible',10,13,'$'
	txt_error3	db	'| ** Error: [03]',13,10
				db	'| - Error al generar archivo',10,13,'$'
	txt_error4	db	'| ** Error: [04]',13,10
				db	'| - Error al cerrar archivo',10,13,'$'
	txt_error5	db	'| ** Error: [05]',13,10
				db	'| - Error al abrir archivo',10,13,'$'
	txt_error6	db	'| ** Error: [06]',13,10
				db	'| - Error al leer archivo',10,13,'$'
	txt_error7	db	'| ** Error: [07]',13,10
				db	'| - Error al crear archivo',10,13,'$'
	txt_show1	db	'| > Generando reporte...',10,13,'$'
	txt_show2	db	'| > se genero el reporte estadoTablero.html',10,13,'$'
	
    txt_comandos 	db	' ',13,10
                    db  '|%%%%%%%%%%%% COMANDOS %%%%%%%%%%%%|',13,10   
                    db	'|%%% PASS - EXIT - SAVE - SHOW  %%%|',13,10
                    db  '|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|',13,10,'$'                            
	
	;--- HTML 

	html_1		db 	"<html><head><title>Juego ARQUI 1</title>"
	html_2		db 	"<style>* {margin: 0;padding: 0;box-sizing: border-box;}"
	html_3		db 	"h1, h2, p {text-align: center;}"
	html_4		db 	"table {background: #C4C4C4; padding: 10px;margin: 25px auto; text-align: center; border: solid 2px;}"
	html_5		db	"td, th {width: 30px;height: 30px; border: solid 1px #c4c4c4}"
	html_6		db 	".circulo {width: 100%;height: 100%;border-radius: 50%;}"
	html_7		db	".f-negra {background: black;}"
	html_8		db	".f-blanca {background: white;}</style>"
	html_9		db 	"</head><body><div style='width: 95%; max-width: 500px; margin: 0 auto; padding: 10px;'>"
	html_10		db 	"<table><tr><th>#</th><th>A</th><th>B</th><th>C</th><th>D</th><th>E</th><th>F</th><th>G</th><th>H</th></tr>"
	html_11		db 	"</table><p>Jose Daniel Lopez Gonzalez | 201503836</p></div></body></html>",'$'
	html_h2_b	db 	"<h2>Ganador Blancas</h2>"
	html_h2_n	db 	"<h2>Ganador Negras</h2>"
	html_tr_in	db	"<tr><th>1</th>"
	html_tr_out	db	"</tr>"
	html_div_b	db	"<td><div class='circulo f-blanca'>&nbsp;</div></td>"
	html_div_n	db	"<td><div class='circulo f-negra'>&nbsp;</div></td>"
	html_div	db	"<td><div class='circulo'>&nbsp;</div></td>"
	
	html_h1		db 	"<h1>23/03/2020 16:45:00</h1>",'$'
	
	;--- Arreglos
	a_matriz	db	40,42,44,46,48,50,52,54
				db 	59,61,63,65,67,69,71,73
				db	78,80,82,84,86,88,90,92
				db	97,99,101,103,105,107,109,111
				db	116,118,120,122,124,126,128,130
				db	135,137,139,141,143,145,147,149
				db 	154,156,158,160,162,164,166,168
				db	173,175,177,179,181,183,185,187,'$'
	a_tablero	db	10 dup( 17 dup('-'),10,13),10,13, '$'
	a_comando	db	5 dup('0'), '$'
	a_temporal	db	5 dup('0'), '$'

	txt_temp1	db	'igual','$'
	txt_temp2	db 	'diferente','$'
;--------------- D - variables -----------------
	v_ficha 	db	'n','$'
	v_pts_b		db	'0', '$'
	v_pts_n		db	'0', '$'
	v_mov		db 	'0', '$'
	v_tmp		dw 	'0', '$'
	v_tmp2		dw 	'0', '$'
	v_tmp3		dw 	'0', '$'
	v_tmp4		dw 	'0', '$'
	v_pass_b	db	00h, '$'
	v_pass_n	db	00h, '$'
	v_f_ano		db	'2020', '$'
	v_f_mes		db 	2 dup (48), '$'
	v_f_dia		db 	2 dup (48), '$'
	v_f_hr		db	2 dup (48), '$'
	v_f_min		db 	2 dup (48), '$'
	v_f_seg		db 	2 dup (48), '$'
	v_num		db 	0, '$'
;--------------- M - ARCHIVOS ------------------
	v_f_html	db	'/rep1.html',0
	v_f_in		db	50 dup('$')
	v_handler	dw	?
	v_buffer	db	7000 dup('$')
;--------------- SEGMENTO DE CODIGO -------------
.code
inicio:

    M_PRINT txt_header
    jmp et_menu
    
et_menu:

    M_MENU txt_menu      ;Imprime menu y espera respuesta
    ;Comparación de ASCII
	cmp al,49			;ascii 49 = numero 1 comparar registro AL
	je et_juego
	cmp al,50           ;ascii 50 = numero 2 comparar registro AL
	je et_cargar_juego
	cmp al,51           ;ascii 51 = numero 3 comparar registro AL
	je Salir
	jne et_menu

et_juego:
	;Limpiar tablero

	mov v_ficha, 110	;Empezar con negras n = 110
	mov v_pts_b, 0		;Puntos en cero
	mov v_pts_n, 0		;Puntos en cero
	mov v_mov, 0		;comando en cero
	mov v_tmp, 0		;Temporal en cero
	mov v_pass_b, 0
	mov v_pass_n, 0

	M_limpiar_tablero a_tablero

	;Iniciar Juego
    M_PRINT txt_jugar
    M_PRINT txt_comandos
	M_PRINT txt_salto

	M_init_juego a_tablero
    M_PRINT a_tablero

	;Empezar a alternar los comandos
	;Empiezan las negras

	xor al, al 			;Limpiar registro AL
	et_inicio_turnos:
		mov al, v_ficha		;Obtiene le valor de v_ficha
		cmp	al, 110			;Compara AL con n
		je et_turno_negras	;Si es igual a n 
		jne et_turno_blancas;No es igual a n

		et_turno_negras:
			xor cl, cl
			et_seguir_negras:
				M_PRINT txt_turnoA
			
				M_READ a_comando	;leer comando
				M_COMPARAR_COMANDO a_comando;comparar comando
				
				mov v_mov[0], cl	;Se guarda valor de comando
				;M_PRINT v_mov

				;Ejecutar comandos
				xor al, al			;Limpiar registro
				mov al, v_mov[0]
				cmp al, 190			;Error
				je et_error_n
				cmp al, 33			;Comando PASS
				je et_comando_b_pass
				cmp al, 34			;Comando EXIT
				je et_comando_exit
				cmp al, 35			;Comando SAVE
				je et_comando_save
				cmp al, 36			;Comando SHOW
				je et_comando_show
				
				;Ejecutar coordenada
				M_Llenar_tablero a_tablero, v_mov, 78, v_pts_n
				;mov bh, 0			;Limpiar registro BH
				;mov bl, v_mov[0]	;Asignar coordenada
				;mov a_tablero[bx], 78;Poner una N en coordenada

				mov al, 0
				mov al, ch
				cmp al, 190
				je et_error_n2

				M_PRINT a_tablero	;Pintar tablero
				mov v_pass_n, 0	;No hay pass
				;Regresar a Inicio con v_ficha = b
				jmp et_comando_next_b

				et_error_n:
					M_PRINT txt_error
					jmp et_seguir_negras

				et_error_n2:
					M_PRINT txt_error2
					jmp et_seguir_negras
					

		et_turno_blancas:
			xor cl, cl
			et_seguir_blancas:
				M_PRINT txt_turnoB
			
				M_READ a_comando	;leer comando
				M_COMPARAR_COMANDO a_comando;comparar comando
				
				mov v_mov[0], cl	;Se guarda valor de comando
				;M_PRINT v_mov

				;Ejecutar comandos
				xor al, al			;Limpiar registro
				mov al, v_mov[0]
				cmp al, 190			;Error
				je et_error_b
				cmp al, 33			;Comando PASS
				je et_comando_n_pass
				cmp al, 34			;Comando EXIT
				je et_comando_exit
				cmp al, 35			;Comando SAVE
				je et_comando_save
				cmp al, 36			;Comando SHOW
				je et_comando_show
				
				;Ejecutar coordenada
				M_Llenar_tablero a_tablero, v_mov, 66, v_pts_b
				;mov bh, 0			;Limpiar registro BH
				;mov bl, v_mov[0]	;Asignar coordenada
				;mov a_tablero[bx], 66;Poner una N en coordenada

				mov al, 0
				mov al, ch
				cmp al, 190
				je et_error_b2

				M_PRINT a_tablero	;Pintar tablero
				mov v_pass_b, 0	;No hay pass
				;Regresar a Inicio con v_ficha = b
				jmp et_comando_next_n

				et_error_b:
					M_PRINT txt_error
					jmp et_seguir_blancas

				et_error_b2:
					M_PRINT txt_error2
					jmp et_seguir_blancas

		;=======================================
		et_comando_b_pass:
		;Pasar turno blancas
			;Verificar si no hay pass
			mov al, v_pass_n
			cmp al, 1
			je et_fin_partida

			mov v_pass_b, 1

			mov v_ficha[0], 98
			jmp et_inicio_turnos

		et_comando_next_b:
			mov v_ficha[0], 98
			jmp et_inicio_turnos

		et_comando_n_pass:
		;Pasar turno negras
			;Verificar si no hay pass
			mov al, v_pass_b
			cmp al, 1
			je et_fin_partida

			mov v_pass_n, 1

			mov v_ficha[0], 110
			jmp et_inicio_turnos
		
		et_comando_next_n:
			mov v_ficha[0], 110
			jmp et_inicio_turnos

		et_comando_save:
			;Guardar juego

			M_PRINT txt_rutaIn
			M_OBTENER_RUTA v_f_in

			M_PRINT txt_salto
			M_PRINT_ASCII 124
			M_PRINT_ASCII 32
			M_PRINT_ASCII 45
			M_PRINT_ASCII 32

			M_PRINT v_f_in
			;Crear archivo
			M_CREAR_ARCHIVO v_f_in
			mov v_handler, ax
			;Escribir archivo
			M_ESCRIBIR_ARCHIVO a_tablero, v_handler, SIZEOF a_tablero -1
			;Cerrar archivo
			M_CERRAR_ARCHIVO v_handler
			jmp et_inicio_turnos

		et_comando_show:
			;Generar reporte 
			;|-> tablero.html 
			M_PRINT txt_show1

			;Abrir archivo
			M_CREAR_ARCHIVO  v_f_html
			mov v_handler, ax
			;Obtener fecha
			mov ah, 2ah
			int 21h
			mov v_num, dh
			M_OBTENER_NUMERO v_f_mes, v_num
			mov v_num, dl
			M_OBTENER_NUMERO v_f_dia, v_num

			;Obtener hora
			mov ah, 2ch
			int 21h
			mov v_num, ch
			M_OBTENER_NUMERO v_f_hr, v_num
			mov v_num, cl 
			M_OBTENER_NUMERO v_f_min, v_num
			mov v_num, dh
			M_OBTENER_NUMERO v_f_seg, v_num
			
			;Colocar fecha en h1
			mov al, v_f_dia[0]
			mov html_h1[4],	al
			mov al, v_f_dia[1]
			mov html_h1[5], al

			mov al, v_f_mes[0]
			mov html_h1[7], al
			mov al, v_f_mes[1]
			mov html_h1[8], al

			mov al, v_f_hr[0]
			mov html_h1[15], al
			mov al, v_f_hr[1]
			mov html_h1[16], al

			mov al, v_f_min[0]
			mov html_h1[18], al
			mov al, v_f_min[1]
			mov html_h1[19], al

			mov al, v_f_seg[0]
			mov html_h1[21], al
			mov al, v_f_seg[1]
			mov html_h1[22], al

			;Escribir HTML
			
			M_ESCRIBIR_ARCHIVO html_1, v_handler, SIZEOF html_1 
			M_ESCRIBIR_ARCHIVO html_2, v_handler, SIZEOF html_2 
			M_ESCRIBIR_ARCHIVO html_3, v_handler, SIZEOF html_3 
			M_ESCRIBIR_ARCHIVO html_4, v_handler, SIZEOF html_4 
			M_ESCRIBIR_ARCHIVO html_5, v_handler, SIZEOF html_5 
			M_ESCRIBIR_ARCHIVO html_6, v_handler, SIZEOF html_6 
			M_ESCRIBIR_ARCHIVO html_7, v_handler, SIZEOF html_7 
			M_ESCRIBIR_ARCHIVO html_8, v_handler, SIZEOF html_8 
			M_ESCRIBIR_ARCHIVO html_9, v_handler, SIZEOF html_9 
			
			M_ESCRIBIR_ARCHIVO html_h1, v_handler, SIZEOF html_h1 - 1
			M_ESCRIBIR_ARCHIVO html_10, v_handler, SIZEOF html_10 

			M_ESCRIBIR_ARCHIVO html_tr_in, v_handler, SIZEOF html_tr_in
			
			;Inicio del ciclo
			mov v_tmp, 64		;Liminte de lectura a_matriz
			mov v_tmp2, 0		;Indice de a_matriz
			mov v_tmp3, 50		;Numeros
			mov v_tmp4, 0		;Indice de posición
			mov cx, 64
			mov bx, 0
			rep1_inicio:
				mov cx, v_tmp
				mov bx, v_tmp2
				mov al, a_matriz[bx]
				mov v_tmp4, ax

				;Comparar
				mov si, v_tmp4
				mov al, a_tablero[si]
				cmp al, 78
				je rep1_ficha_negra
				cmp al, 66
				je rep1_ficha_blanca
				jne rep1_ficha_null

				rep1_seguir: 
					mov ax, v_tmp4
					cmp al, 54
					je rep1_tr_fin
					cmp al, 73
					je rep1_tr_fin
					cmp al, 92
					je rep1_tr_fin
					cmp al, 111
					je rep1_tr_fin
					cmp al, 130
					je rep1_tr_fin
					cmp al, 149
					je rep1_tr_fin
					cmp al, 168
					je rep1_tr_fin
					
					jmp rep1_loop

			rep1_ficha_negra:
				M_ESCRIBIR_ARCHIVO html_div_n, v_handler, SIZEOF html_div_n
				jmp rep1_seguir

			rep1_ficha_blanca:
				M_ESCRIBIR_ARCHIVO html_div_b, v_handler, SIZEOF html_div_b
				jmp rep1_seguir

			rep1_ficha_null:
				M_ESCRIBIR_ARCHIVO html_div, v_handler, SIZEOF html_div
				jmp rep1_seguir

			rep1_tr_fin:
				mov ax, v_tmp3
				mov html_tr_in[8], al
				M_ESCRIBIR_ARCHIVO html_tr_out, v_handler, SIZEOF html_tr_out
				M_ESCRIBIR_ARCHIVO html_tr_in, v_handler, SIZEOF html_tr_in
				add v_tmp3, 1
				jmp rep1_loop

			rep1_loop:
				add v_tmp2, 1
				sub v_tmp, 1
				
				cmp v_tmp, 0
				je rep1_fin
				jmp rep1_inicio

			rep1_fin:
			;Terminar con el ciclo
			M_ESCRIBIR_ARCHIVO html_tr_out, v_handler, SIZEOF html_tr_out
			
			M_ESCRIBIR_ARCHIVO html_11, v_handler, SIZEOF html_11 - 1
			
			
			M_PRINT txt_show2
			M_CERRAR_ARCHIVO v_handler
			jmp et_inicio_turnos

		et_comando_exit:
			;Regresar a menu
			jmp et_menu				
		;========================================

		et_error_abrir_archivo:
			M_PRINT txt_error5
			add ax, 48
    		mov v_tmp, ax
			M_PRINT v_tmp
			jmp et_juego
		
		et_error_cerrar_archivo:
			M_PRINT txt_error4
			add ax, 48
    		mov v_tmp, ax
			M_PRINT v_tmp
			jmp et_juego

		et_error_generar_archivo:
			M_PRINT txt_error3
			add ax, 48
    		mov v_tmp, ax
			M_PRINT v_tmp
			jmp et_inicio_turnos

		et_error_leer_archivo:
			M_PRINT txt_error6
			add ax, 48
    		mov v_tmp, ax
			M_PRINT v_tmp
			jmp et_juego

		et_error_crear_archivo:
			M_PRINT txt_error7
			add ax, 48
    		mov v_tmp, ax
			M_PRINT v_tmp
			jmp et_inicio_turnos

    jmp Salir

	et_fin_partida:
		M_PRINT txt_fin

		mov cl, v_pts_b
		mov bl, v_pts_n

		cmp cl, bl
		ja et_win_blancas
		jb et_win_negras
		je et_win_blancas

		et_win_blancas:
			M_PRINT txt_win_b
			M_PRINT txt_salto
	
			;Generar reporte Blancas
			;Abrir archivo
			M_CREAR_ARCHIVO  v_f_html
			mov v_handler, ax
			;Obtener fecha
			mov ah, 2ah
			int 21h
			mov v_num, dh
			M_OBTENER_NUMERO v_f_mes, v_num
			mov v_num, dl
			M_OBTENER_NUMERO v_f_dia, v_num

			;Obtener hora
			mov ah, 2ch
			int 21h
			mov v_num, ch
			M_OBTENER_NUMERO v_f_hr, v_num
			mov v_num, cl 
			M_OBTENER_NUMERO v_f_min, v_num
			mov v_num, dh
			M_OBTENER_NUMERO v_f_seg, v_num
			
			;Colocar fecha en h1
			mov al, v_f_dia[0]
			mov html_h1[4],	al
			mov al, v_f_dia[1]
			mov html_h1[5], al

			mov al, v_f_mes[0]
			mov html_h1[7], al
			mov al, v_f_mes[1]
			mov html_h1[8], al

			mov al, v_f_hr[0]
			mov html_h1[15], al
			mov al, v_f_hr[1]
			mov html_h1[16], al

			mov al, v_f_min[0]
			mov html_h1[18], al
			mov al, v_f_min[1]
			mov html_h1[19], al

			mov al, v_f_seg[0]
			mov html_h1[21], al
			mov al, v_f_seg[1]
			mov html_h1[22], al

			;Escribir HTML
			
			M_ESCRIBIR_ARCHIVO html_1, v_handler, SIZEOF html_1 
			M_ESCRIBIR_ARCHIVO html_2, v_handler, SIZEOF html_2 
			M_ESCRIBIR_ARCHIVO html_3, v_handler, SIZEOF html_3 
			M_ESCRIBIR_ARCHIVO html_4, v_handler, SIZEOF html_4 
			M_ESCRIBIR_ARCHIVO html_5, v_handler, SIZEOF html_5 
			M_ESCRIBIR_ARCHIVO html_6, v_handler, SIZEOF html_6 
			M_ESCRIBIR_ARCHIVO html_7, v_handler, SIZEOF html_7 
			M_ESCRIBIR_ARCHIVO html_8, v_handler, SIZEOF html_8 
			M_ESCRIBIR_ARCHIVO html_9, v_handler, SIZEOF html_9 
			
			M_ESCRIBIR_ARCHIVO html_h1, v_handler, SIZEOF html_h1 - 1
			M_ESCRIBIR_ARCHIVO html_h2_b, v_handler, SIZEOF html_h2_b 
			M_ESCRIBIR_ARCHIVO html_10, v_handler, SIZEOF html_10 

			M_ESCRIBIR_ARCHIVO html_tr_in, v_handler, SIZEOF html_tr_in
			
			;Inicio del ciclo
			mov v_tmp, 64		;Liminte de lectura a_matriz
			mov v_tmp2, 0		;Indice de a_matriz
			mov v_tmp3, 50		;Numeros
			mov v_tmp4, 0		;Indice de posición
			mov cx, 64
			mov bx, 0
			repb_inicio:
				mov cx, v_tmp
				mov bx, v_tmp2
				mov al, a_matriz[bx]
				mov v_tmp4, ax

				;Comparar
				mov si, v_tmp4
				mov al, a_tablero[si]
				cmp al, 78
				je repb_ficha_negra
				cmp al, 66
				je repb_ficha_blanca
				jne repb_ficha_null

				repb_seguir: 
					mov ax, v_tmp4
					cmp al, 54
					je repb_tr_fin
					cmp al, 73
					je repb_tr_fin
					cmp al, 92
					je repb_tr_fin
					cmp al, 111
					je repb_tr_fin
					cmp al, 130
					je repb_tr_fin
					cmp al, 149
					je repb_tr_fin
					cmp al, 168
					je repb_tr_fin
					
					jmp repb_loop

			repb_ficha_negra:
				M_ESCRIBIR_ARCHIVO html_div_n, v_handler, SIZEOF html_div_n
				jmp repb_seguir

			repb_ficha_blanca:
				M_ESCRIBIR_ARCHIVO html_div_b, v_handler, SIZEOF html_div_b
				jmp repb_seguir

			repb_ficha_null:
				M_ESCRIBIR_ARCHIVO html_div, v_handler, SIZEOF html_div
				jmp repb_seguir

			repb_tr_fin:
				mov ax, v_tmp3
				mov html_tr_in[8], al
				M_ESCRIBIR_ARCHIVO html_tr_out, v_handler, SIZEOF html_tr_out
				M_ESCRIBIR_ARCHIVO html_tr_in, v_handler, SIZEOF html_tr_in
				add v_tmp3, 1
				jmp repb_loop

			repb_loop:
				add v_tmp2, 1
				sub v_tmp, 1
				
				cmp v_tmp, 0
				je repb_fin
				jmp repb_inicio

			repb_fin:
			;Terminar con el ciclo
			M_ESCRIBIR_ARCHIVO html_tr_out, v_handler, SIZEOF html_tr_out
			
			M_ESCRIBIR_ARCHIVO html_11, v_handler, SIZEOF html_11 - 1

			M_CERRAR_ARCHIVO v_handler


			mov ah, 01h		;funcion 8, esperaque el usuario presione una tecla, sin echo
			int 21h

			jmp et_menu



		et_win_negras:
			M_PRINT txt_win_n
			M_PRINT txt_salto

			;Generar reporte Blancas
			;Abrir archivo
			M_CREAR_ARCHIVO  v_f_html
			mov v_handler, ax
			;Obtener fecha
			mov ah, 2ah
			int 21h
			mov v_num, dh
			M_OBTENER_NUMERO v_f_mes, v_num
			mov v_num, dl
			M_OBTENER_NUMERO v_f_dia, v_num

			;Obtener hora
			mov ah, 2ch
			int 21h
			mov v_num, ch
			M_OBTENER_NUMERO v_f_hr, v_num
			mov v_num, cl 
			M_OBTENER_NUMERO v_f_min, v_num
			mov v_num, dh
			M_OBTENER_NUMERO v_f_seg, v_num
			
			;Colocar fecha en h1
			mov al, v_f_dia[0]
			mov html_h1[4],	al
			mov al, v_f_dia[1]
			mov html_h1[5], al

			mov al, v_f_mes[0]
			mov html_h1[7], al
			mov al, v_f_mes[1]
			mov html_h1[8], al

			mov al, v_f_hr[0]
			mov html_h1[15], al
			mov al, v_f_hr[1]
			mov html_h1[16], al

			mov al, v_f_min[0]
			mov html_h1[18], al
			mov al, v_f_min[1]
			mov html_h1[19], al

			mov al, v_f_seg[0]
			mov html_h1[21], al
			mov al, v_f_seg[1]
			mov html_h1[22], al

			;Escribir HTML
			
			M_ESCRIBIR_ARCHIVO html_1, v_handler, SIZEOF html_1 
			M_ESCRIBIR_ARCHIVO html_2, v_handler, SIZEOF html_2 
			M_ESCRIBIR_ARCHIVO html_3, v_handler, SIZEOF html_3 
			M_ESCRIBIR_ARCHIVO html_4, v_handler, SIZEOF html_4 
			M_ESCRIBIR_ARCHIVO html_5, v_handler, SIZEOF html_5 
			M_ESCRIBIR_ARCHIVO html_6, v_handler, SIZEOF html_6 
			M_ESCRIBIR_ARCHIVO html_7, v_handler, SIZEOF html_7 
			M_ESCRIBIR_ARCHIVO html_8, v_handler, SIZEOF html_8 
			M_ESCRIBIR_ARCHIVO html_9, v_handler, SIZEOF html_9 
			
			M_ESCRIBIR_ARCHIVO html_h1, v_handler, SIZEOF html_h1 - 1
			M_ESCRIBIR_ARCHIVO html_h2_n, v_handler, SIZEOF html_h2_n 
			M_ESCRIBIR_ARCHIVO html_10, v_handler, SIZEOF html_10 

			M_ESCRIBIR_ARCHIVO html_tr_in, v_handler, SIZEOF html_tr_in
			
			;Inicio del ciclo
			mov v_tmp, 64		;Liminte de lectura a_matriz
			mov v_tmp2, 0		;Indice de a_matriz
			mov v_tmp3, 50		;Numeros
			mov v_tmp4, 0		;Indice de posición
			mov cx, 64
			mov bx, 0
			repn_inicio:
				mov cx, v_tmp
				mov bx, v_tmp2
				mov al, a_matriz[bx]
				mov v_tmp4, ax

				;Comparar
				mov si, v_tmp4
				mov al, a_tablero[si]
				cmp al, 78
				je repn_ficha_negra
				cmp al, 66
				je repn_ficha_blanca
				jne repn_ficha_null

				repn_seguir: 
					mov ax, v_tmp4
					cmp al, 54
					je repn_tr_fin
					cmp al, 73
					je repn_tr_fin
					cmp al, 92
					je repn_tr_fin
					cmp al, 111
					je repn_tr_fin
					cmp al, 130
					je repn_tr_fin
					cmp al, 149
					je repn_tr_fin
					cmp al, 168
					je repn_tr_fin
					
					jmp repn_loop

			repn_ficha_negra:
				M_ESCRIBIR_ARCHIVO html_div_n, v_handler, SIZEOF html_div_n
				jmp repn_seguir

			repn_ficha_blanca:
				M_ESCRIBIR_ARCHIVO html_div_b, v_handler, SIZEOF html_div_b
				jmp repn_seguir

			repn_ficha_null:
				M_ESCRIBIR_ARCHIVO html_div, v_handler, SIZEOF html_div
				jmp repn_seguir

			repn_tr_fin:
				mov ax, v_tmp3
				mov html_tr_in[8], al
				M_ESCRIBIR_ARCHIVO html_tr_out, v_handler, SIZEOF html_tr_out
				M_ESCRIBIR_ARCHIVO html_tr_in, v_handler, SIZEOF html_tr_in
				add v_tmp3, 1
				jmp repn_loop

			repn_loop:
				add v_tmp2, 1
				sub v_tmp, 1
				
				cmp v_tmp, 0
				je repn_fin
				jmp repn_inicio

			repn_fin:
			;Terminar con el ciclo
			M_ESCRIBIR_ARCHIVO html_tr_out, v_handler, SIZEOF html_tr_out
			
			M_ESCRIBIR_ARCHIVO html_11, v_handler, SIZEOF html_11 - 1
			
			M_CERRAR_ARCHIVO v_handler


			mov ah, 01h		;funcion 8, esperaque el usuario presione una tecla, sin echo
			int 21h

			jmp et_menu

et_cargar_juego:

	M_PRINT txt_salto
    M_PRINT txt_cargar_juego
	;pedir ruta
	M_PRINT txt_salto
	M_PRINT txt_rutaIn
	M_OBTENER_RUTA v_f_in
	;Abrir archivo
	M_ABRIR_ARCHIVO v_f_in, v_handler
	;Leer archivo
	M_LEER_ARCHIVO v_handler, a_tablero, SIZEOF a_tablero
	;M_ESCRIBIR_ARCHIVO a_tablero, v_handler, SIZEOF a_tablero -1
	;Cerrar archivo
	M_CREAR_ARCHIVO v_f_in
	;Jugar

	M_PRINT a_tablero
    jmp et_inicio_turnos

Salir:
	
    mov ah,04ch
    int 21h

end       
       
