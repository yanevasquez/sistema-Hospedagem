/* Item 3.d - Índices  */


/* 1- Índice para a data de entrada (checkin) da reserva */
create index entradaIn on reserva(entrada);

/* 2- Índice para a data de saída (checkout) da reserva */
create index saindaIn on reserva(saida);

/* 3- Índice para status de disponibilidade da acomodação */
create index statusIn on usuario(statusac);

/* Item 3.e - Reescrita de consultas */

/* 1- */


