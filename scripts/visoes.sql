/* Item 3.c- Visões */

/* 1- Visão para exibir usuários e os totalizadores para o número reservas por mês e ano */
CREATE OR REPLACE VIEW reservasPorMesAno (cliente, mes, ano, "Total de reservas") AS 
    SELECT usuario.nome, EXTRACT(MONTH FROM entrada) mes, EXTRACT(YEAR FROM entrada) ano, COUNT (id_reserva) AS "total" FROM reserva 
        JOIN usuario ON reserva.fk_idusuario = usuario.id_usuario  
    GROUP BY ROLLUP ((mes, ano, usuario.nome)) ORDER BY mes, usuario.nome;

SELECT * FROM reservasPorMesAno;

/* 2- Uma visão dos imóveis que ainda não possuem reservas, exibindo informacoes sobre 
nome, cidade, bairro, preco, descricao da acomodacao, o tipo e quantidade para acomodar */
CREATE OR REPLACE VIEW atributosImoveisSemReserva ("Nome do imóvel", cidade, bairro, caracteristicas, tipo, qtd) AS    
    SELECT  i.nome, i.cidade, i.bairro, a.preco, a.descricao, t.descricao, a.quantidade FROM reserva r 
        RIGHT JOIN imovel i ON r.fk_idimovel = i.id_imovel 
        JOIN imovel_acomodacao ia ON i.id_imovel = ia.fk_idimovel 
        JOIN acomodacao a ON ia.fk_idacomodacao = a.id_acomodacao  
        JOIN tipo t ON a.fk_idtipo = t.id_tipo WHERE r.fk_idimovel IS NULL;

SELECT * FROM atributosImoveisSemReserva;

/* 3- View com check option que só permite insercao se o status da acomodacao a inserir for do tipo 'D' disponível,
a view irá exibir código, codigo do tipo, nome, a descricao, preco, quantidade e staus das acomodações */
create or replace view statusAcomodacao(codigo, imovel, descricao, preco, status, quant, codtipo) as
	select ac.id_acomodacao, ac.nome, ac.descricao, ac.preco, ac.statusac, ac.fk_idtipo, ac.quantidade from acomodacao ac where ac.statusac='D'
	with check option;

--Testes
select * from statusAcomodacao;

insert into statusAcomodacao (codigo, imovel, descricao, preco, status, quant, codtipo) 
	values (79, 'Cabana', 'Chalé com cama box, cozinha compacta, banheiro, varanda', '310','D', 1, 1);





