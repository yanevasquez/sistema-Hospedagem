/* Item 3.b- Criação e uso de objetos básicos */

/* 1- Usuarios que não possui profissão cadastrada*/
SELECT * FROM usuario
WHERE profissao IS null

/* 2- Exibir nomes dos usuarios com data de entrada e data de saida de suas reservas */
SELECT u.nome AS "Nome", r.entrada AS "Entrada", r.saida AS "Saída" 
FROM usuario u 
INNER JOIN reserva r ON u.id_usuario = r.fk_Idusuario

/* 3- Identificar quais os tipos de acomodacoes que possuem mais hospedagens */
select t.id_tipo as id, t.descricao as tipo, count(t.id_tipo) as quantidadeReservas 
from reserva r 
    join imovel on r.fk_idimovel=imovel.id_imovel 
    join imovel_acomodacao ia on imovel.id_imovel=ia.fk_idimovel 
    join acomodacao a on ia.fk_idacomodacao=a.id_acomodacao 
    join tipo t on a.fk_idtipo =t.id_tipo 
group by id, tipo order by quantidadeReservas desc

/* 4- Exibir os destinos mais procurados e total de reservas */
SELECT imovel.cidade AS "Destinos mais Procurados", COUNT(reserva.fk_Idimovel) AS "Quantidade de reservas"
FROM reserva  
JOIN imovel ON reserva.fk_idimovel=imovel.id_imovel GROUP BY cidade

/* 5- O nome e código do imoveis que ainda não possuem reservas */
select i.nome as "Nome do imóvel", i.id_imovel as "código do imovel" from reserva r 
    right join imovel i on r.fk_idimovel=i.id_imovel 
where r.fk_idimovel is null  

/* 6- Preço Médio das reservas agrupados pelos bairros*/
SELECT bairro AS "Bairro", ROUND(AVG(r.preco), 2) AS "Preço Médio das Reservas"
FROM imovel i
INNER JOIN reserva r ON i.id_imovel = r.fk_idimovel
GROUP BY i.bairro

/* 7- Exibir a média de idade dos usuário cadastrados no sistema. Exibir apenas o nome e 
profissao onde essa média de idade seja menor ou igual 30 anos */
SELECT nome, profissao, AVG(date_part('year', age(aniversario))) Idade 
FROM usuario GROUP BY nome, profissao
HAVING AVG(date_part('year',age(aniversario))) <= 30;

/* 8- O código dos usuários que estão cadastrados mas não fizeram reserva */
select id_usuario from usuario except select fk_idusuario from reserva

/* 9- Exibir o nome dos moveis, a cidade e datas das suas reservas*/

/* Com subquery */
SELECT imovel.nome, imovel.cidade,
(
	SELECT entrada
	FROM reserva
	WHERE imovel.id_imovel = reserva.fk_idimovel LIMIT 1
),
(
	SELECT saida
	FROM reserva
	WHERE imovel.id_imovel = reserva.fk_idimovel LIMIT 1
)
FROM imovel
GROUP BY imovel.id_imovel

    /* Rescrita da consulta 9 com JOIN */
	SELECT i.nome AS "Nome", i.cidade AS "Cidade", r.entrada AS "Entrada", r.saida AS "Saída"
    FROM imovel i
    INNER JOIN reserva r ON i.id_imovel = r.fk_idimovel

/* 10- Exibir os nomes dos usuarios, valor das reservas e quantidade de reservas - versão subquery*/
SELECT u.nome, 
(
	SELECT COUNT(r.fk_idusuario)
	FROM reserva r
	WHERE u.id_usuario = r.fk_idusuario
) AS "Número de Reservas", 
(
	SELECT SUM(r.preco) 
	FROM reserva r
	WHERE u.id_usuario = r.fk_idusuario
) AS "Valor da reserva"
FROM usuario u
GROUP BY u.id_usuario
ORDER BY "Número de Reservas" DESC
    
    /* Rescrita da consulta 10 com JOIN */
    SELECT u.nome AS "Nome", COUNT(r.fk_idusuario) AS "Número de Reservas", SUM(r.preco) AS "Valor da reserva"
    FROM usuario u
    INNER JOIN reserva r ON u.id_usuario = r.fk_idusuario
    GROUP BY u.id_usuario
    ORDER BY COUNT(r.fk_idusuario) DESC

/* Justificativa: O uso de join na reescrita fornece um resultado mais rápido porque 
    quando comparado a subquery temos que a projecao só irá exibir os resultados quando a(as) 
    consulta(as) mais interna(as) for(em) realizadas.
*/
