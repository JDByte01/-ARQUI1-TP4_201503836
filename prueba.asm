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

	txt_salto	db 	13,10, '$'
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
	
    txt_comandos    db	' ',13,10
                    db  '|%%%%%%%%%%%% COMANDOS %%%%%%%%%%%%|',13,10   
                    db	'|%%% PASS - EXIT - SAVE - SHOW  %%%|',13,10
                    db  '|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|',13,10,'$'                            
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
	v_tmp		db 	'0', '$'
;--------------- M - ARCHIVOS ------------------
	v_f_html	db	'tablero.html',0
	v_f_in		db	50 dup('$')
	v_handler	dw	?
	v_buffer	db	500 dup('$')
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
				M_Llenar_tablero a_tablero, v_mov, 78
				;mov bh, 0			;Limpiar registro BH
				;mov bl, v_mov[0]	;Asignar coordenada
				;mov a_tablero[bx], 78;Poner una N en coordenada

				mov al, 0
				mov al, ch
				cmp al, 190
				je et_error_n2

				M_PRINT a_tablero	;Pintar tablero
				
				;Regresar a Inicio con v_ficha = b
				jmp et_comando_b_pass

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
				M_Llenar_tablero a_tablero, v_mov, 66
				;mov bh, 0			;Limpiar registro BH
				;mov bl, v_mov[0]	;Asignar coordenada
				;mov a_tablero[bx], 66;Poner una N en coordenada

				mov al, 0
				mov al, ch
				cmp al, 190
				je et_error_b2

				M_PRINT a_tablero	;Pintar tablero
				
				;Regresar a Inicio con v_ficha = b
				jmp et_comando_n_pass

				et_error_b:
					M_PRINT txt_error
					jmp et_seguir_blancas

				et_error_b2:
					M_PRINT txt_error2
					jmp et_seguir_blancas

		;=======================================
		et_comando_b_pass:
		;Pasar turno blancas
			mov v_ficha[0], 98
			jmp et_inicio_turnos

		et_comando_n_pass:
		;Pasar turno negras
			mov v_ficha[0], 110
			jmp et_inicio_turnos

		et_comando_save:
			;Guardar juego
			M_PRINT_ASCII 83
			M_PRINT_ASCII 97
			M_PRINT_ASCII 86
			M_PRINT_ASCII 69

			jmp et_menu

		et_comando_show:
			;Generar reporte 
			;|-> tablero.html 

			M_PRINT txt_show1

			;Abrir archivo
			M_ABRIR_ARCHIVO  v_f_html, v_handler;Enviamos el Handler
			M_PRINT txt_show2
			M_CERRAR_ARCHIVO v_handler
			jmp et_menu

		et_comando_exit:
			;Regresar a menu
			jmp et_menu				
		;========================================

		et_error_abrir_archivo:
			M_PRINT txt_error5

			jmp et_menu
		
		et_error_cerrar_archivo:
			M_PRINT txt_error4

			jmp et_menu

		et_error_generar_archivo:
			M_PRINT txt_error3

			jmp et_menu

		et_error_leer_archivo:
			M_PRINT txt_error6

			jmp et_menu

		et_error_crear_archivo:
			M_PRINT txt_error7

			jmp et_menu

    jmp Salir

et_cargar_juego:

    M_PRINT txt_cargar_juego
    jmp et_menu

Salir:
    mov ah,04ch
    int 21h

end       
       
