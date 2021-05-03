/* Item 3.f  Funções ou procedures armazenadas */


/* 1- Exibir o percentual de reservas feitas por profissão do usuário*/
CREATE OR REPLACE PROCEDURE percentReservasPorProfissao()
language plpgsql
as $$
declare 
	contagem integer;
	valores numeric;
	somatorio integer;	
	profissao varchar;	
	percentual numeric;
	
	cursorli cursor for select distinct(u.profissao), count(fk_idusuario) as contagem from usuario u
	join reserva r on u.id_usuario=r.fk_idusuario group by u.profissao order by contagem desc;
	
BEGIN	
for vlista in cursorli loop
	
	select distinct(u.profissao)into profissao from usuario u
		join reserva r on u.id_usuario=r.fk_idusuario group by u.profissao;
		
	select sum(soma.contador) into somatorio from 
			(select count(r.fk_idusuario) as contador from usuario u
				join reserva r on u.id_usuario=r.fk_idusuario 
				group by r.fk_idusuario order by contador desc) as soma;	
	valores:=vlista.contagem;
	profissao=vlista.profissao;
	percentual:=round((valores/somatorio)*100, 2);
	raise notice '% das reservas feitas por %', percentual || '%', profissao ;
end loop;
END $$;

call percentReservasPorProfissao();