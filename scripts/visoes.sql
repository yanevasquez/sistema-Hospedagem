/* Item 3.c- Visões */

/* 1- Visão para exibir usuários e os totalizadores para o número reservas por mês e ano */
create or replace view reservasPorMesAno (cliente, mes, ano, "Total de reservas") as 
    select usuario.nome, extract(month from entrada) mes, extract(year from entrada) ano, count (id_reserva) as "total" from reserva 
        join usuario on reserva.fk_idusuario=usuario.id_usuario  
    group by rollup ((mes, ano, usuario.nome)) order by mes, usuario.nome;

select * from reservasPorMesAno;

