/* Item 3.g Triggers


/* 1- Trigger para realizar reserva somente se as datas estiverem disponíveis, ou seja, 
 só permite não permite reserva de outro cliente para datas iguais */

create or replace function validarDatasdeReservas() returns trigger
as $$
declare 
	dataEnt date;
    dataSai date;
    dentroInter date;
	
    cursEntrSaida cursor for select r.entrada, r.saida from reserva r join imovel i on r.fk_idimovel=i.id_imovel;
    cursDentroIntervalo cursor for select r.saida as dentro from reserva r join imovel i on r.fk_idimovel=i.id_imovel where r.saida=new.saida;
	begin
		for i in cursEntrSaida loop
			dataEnt:=i.entrada;
			dataSai:=i.saida;
			for j in cursDentroIntervalo  loop
				if ((dataEnt = new.entrada) and (dataSai = new.saida)) then
				end if;
			dentroInter:= j.dentro;
				if ((new.entrada <= dentroInter) and (new.saida >= dentroInter)) then
					raise exception 'exc';
				end if;
			end loop;
			return new;
		end loop;
	exception
		when raise_exception then 
			raise notice 'Reserva indisponível para essas datas!!';
		return null;
	end;
$$ language plpgsql;

create trigger validacaoReserva
before insert or update or delete on reserva
for each row 
execute procedure validarDatasdeReservas()

select id_reserva, entrada, saida from reserva;

--Teste de inserção de datas indisponíveis
insert into reserva (id_reserva, fk_Idusuario, fk_Idimovel, entrada, saida, preco) values(20, 1, 4,'26-05-2021','30-05-2021', 1200.00);