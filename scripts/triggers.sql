/* Item 3.g Triggers

/* 1- Trigger para realizar reserva somente se as datas estiverem disponíveis, ou seja, 
não permite reserva de outro cliente para datas iguais */
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
			for j in cursDentroIntervalo loop
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

/*Teste de inserção de datas*/

--dentro do intervalo de datas
insert into reserva (id_reserva, fk_Idusuario, fk_Idimovel, entrada, saida, preco) values(888, 1, 4,'02-06-2021','03-06-2021', 1200.00);
--mesma data
insert into reserva (id_reserva, fk_Idusuario, fk_Idimovel, entrada, saida, preco) values(999, 1, 4,'28-05-2021','30-05-2021', 1200.00);
--data nova
insert into reserva (id_reserva, fk_Idusuario, fk_Idimovel, entrada, saida, preco) values(555, 1, 4,'02-06-2024','03-06-2024', 1200.00);

/* 2- Trigger para permitir a atualização dos dados da reserva */
create or replace function atualizarReserva()
returns trigger AS $$
	declare 
	BEGIN
		if (TG_OP = 'DELETE') then
			update reserva set id_reserva = OLD.id_reserva where reserva.id_reserva = OLD.id_reserva 
				and reserva.fk_idusuario = OLD.fk_idusuario
				and reserva.fk_idimovel = OLD.fk_idimovel
				and reserva.entrada = OLD.entrada 
				and reserva.saida = OLD.saida;
			return OLD;
		elseif (TG_OP = 'INSERT') then 
			update reserva set id_reserva = NEW.id_reserva where reserva.id_reserva = NEW.id_reserva
				and reserva.fk_idusuario = NEW.fk_idusuario
				and reserva.fk_idimovel = NEW.fk_idimovel
				and reserva.entrada = NEW.entrada 
				and reserva.saida = NEW.saida;
			return NEW;
		end if;
	END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER reservaUp
AFTER INSERT OR DELETE ON reserva
FOR EACH ROW
EXECUTE PROCEDURE atualizarReserva();

--Testes
delete from reserva where id_reserva=11;
insert into reserva (id_reserva, fk_Idusuario, fk_Idimovel, entrada, saida, preco) values(11, 1, 4,'28-05-2021','30-05-2021', 1200.00);
select * from reserva

/* 3- Trigger para armazenar infos do usuário do banco e quais as operações de insert, update e delete foram feitas na tabela reserva */

--Criando a tabela de log de operações na tabela reserva
CREATE TABLE Reservalog(usuario varchar(20), operacao char(1), datahora timestamp);

CREATE OR REPLACE FUNCTION registraLog() 
RETURNS TRIGGER 
AS $$
BEGIN 
	INSERT INTO ReservaLog values(USER, SUBSTRING(TG_OP,1,1), NOW());
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertLog
AFTER INSERT OR UPDATE OR DELETE ON reserva
FOR EACH ROW EXECUTE PROCEDURE registraLog()

--Teste de operacoes
insert into reserva (id_reserva, fk_Idusuario, fk_Idimovel, entrada, saida, preco) values(44, 1, 4,'01-02-2022','02-02-2022', 530.00);
delete from reserva where id_reserva=44;
update reserva set id_reserva = 44 where id_reserva = 45;

--Conferindo os resultados das operacoes
select * from Reservalog;

