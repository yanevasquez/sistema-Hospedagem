/* Item 3.f  Function ou procedures armazenadas */

/* 1- Exibir o percentual de reservas feitas por profissão do usuário */
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


/* 2- Exibe o nome dos imóveis que estão disponíveis para as datas de entrada e a data de saída passadas 
por parâmetros, caso não exista imóvel disponível uma exceção é lançada indicando indisponibilidade. */
CREATE OR REPLACE FUNCTION exibeImoveisDisponiveis(dataEntrada date, dataSaida date )
returns  varchar as $$

declare 
	exibirImoveis varchar;
	validaImovel varchar;

	cursorLi CURSOR for select i.nome as nomes from imovel i where NOT exists 
		(select * from reserva r where r.fk_idimovel=i.id_imovel and r.saida > dataEntrada and r.entrada < dataSaida)	
	UNION 
	select i.nome from reserva r right join imovel i on r.fk_idimovel=i.id_imovel  where r.fk_idimovel is null 
	EXCEPT
	select i.nome  from reserva r 
		join imovel i on r.fk_idimovel=i.id_imovel 
		join imovel_acomodacao ia on i.id_imovel=ia.fk_idimovel 
		join acomodacao a on ia.fk_idacomodacao=a.id_acomodacao 
	where a.statusac='I';
	
BEGIN

	select i.nome INTO validaImovel from imovel i where NOT exists 
		(select * from reserva r where r.fk_idimovel=i.id_imovel and r.saida > dataEntrada and r.entrada < dataSaida)	
	UNION
	select i.nome  from reserva r right join imovel i on r.fk_idimovel=i.id_imovel  where r.fk_idimovel is null 
	EXCEPT
	select  i.nome  from reserva r join imovel i on r.fk_idimovel=i.id_imovel 
		join imovel_acomodacao ia on i.id_imovel=ia.fk_idimovel 
		join acomodacao a on ia.fk_idacomodacao=a.id_acomodacao where a.statusac='I';

	if validaImovel is null then
		raise exception 'go to exception';	
		end if;

	FOR vl in cursorli LOOP
		exibirImoveis:=vl.nomes;
		raise notice 'Imóvel disponível: %', exibirImoveis;
	END LOOP;
	exception
		when raise_exception then
			return 'Não existe imóveis disponíveis para reservar';
END;	
$$ language plpgsql;

--Testes para checar status 
select * from acomodacao
update acomodacao set statusac='D' whEre id_acomodacao=5;
select * from exibeImoveisDisponiveis('05-03-2021', '06-03-2021')


/* 3- Procedure para exibir os meses com mais fluxo de reservas */
CREATE OR REPLACE PROCEDURE mesesMaisReservas()
language plpgsql
as $$
declare 
	contagem interval ;
	valores integer;
	
	cursorli cursor for select extract(month from entrada) as contagem, count(*) as total 
	from reserva group by contagem order by total desc;	
BEGIN	
	raise notice 'Ranking  | Total de reservas';
	for vlista in cursorli loop
		raise notice '  Mês %    ----> %', vlista.contagem, vlista.total;
	end loop;
END $$;

call mesesMaisReservas();

/* 4- Procedure que conta quantas vendas fez cada imovel e caso não exista a exceção é lançada */
CREATE OR REPLACE PROCEDURE Estatisticavendas(nomeimovel varchar(40))
LANGUAGE plpgsql
AS $$
DECLARE
contador integer := 0;
BEGIN
	Select Count(*) Into contador 
	From imovel i Join reserva r On i.id_imovel = r.fk_idusuario
	Where i.nome = nomeimovel;
	IF contador = 0 THEN
		Raise Exception Raise_Exception;
	END IF;

	Raise Notice '% Fez % reservas', nomeimovel, contador;

	EXCEPTION 
	When Raise_Exception Then
		Raise exception 'Esse imovel não fez nenhuma venda ou não existe.';
    When Others Then
		Raise exception 'Erro desconhecido';
END $$;

call Estatisticavendas('Casa na praia');

