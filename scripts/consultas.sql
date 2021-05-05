/* Item 3.b- Criação e uso de objetos básicos */


/* 1- Usuarios que não possui profissão cadastrada*/
SELECT * FROM usuario
WHERE profissao IS null

/* 2- Exibir nomes dos usuarios com data de entrada e data de saida de suas reservas */
SELECT u.nome AS "Nome", r.entrada AS "Entrada", r.saida AS "Saída" 
FROM usuario u 
INNER JOIN reserva r ON u.id_usuario = r.fk_Idusuario

/* 3- Exibir os destinos mais procurados e total de reservas */
SELECT imovel.cidade AS "Destinos mais Procurados", COUNT(reserva.fk_Idimovel) AS "Quantidade de reservas"
FROM reserva  
JOIN imovel ON reserva.fk_idimovel=imovel.id_imovel GROUP BY cidade

/* 4- Exibir os nomes dos usuarios, valor das reservas e quantidade de reservas */
SELECT u.nome AS "Nome", COUNT(r.fk_idusuario) AS "Número de Reservas", SUM(r.preco) AS "Valor da reserva"
FROM usuario u
INNER JOIN reserva r ON u.id_usuario = r.fk_idusuario
GROUP BY u.id_usuario
ORDER BY COUNT(r.fk_idusuario) DESC

/* 5- O código dos usuários que estão cadastrados mas não fizeram reserva */
select id_usuario from usuario except select fk_idusuario from reserva

/* 6- O nome e código do imoveis que ainda não possuem reservas */
select i.nome as "Nome do imóvel", i.id_imovel as "código do imovel" from reserva r 
    right join imovel i on r.fk_idimovel=i.id_imovel 
where r.fk_idimovel is null  

/* 7- Preço Médio das reservas agrupados pelos bairros*/
SELECT bairro AS "Bairro", ROUND(AVG(r.preco), 2) AS "Preço Médio das Reservas"
FROM imovel i
INNER JOIN reserva r ON i.id_imovel = r.fk_idimovel
GROUP BY i.bairro

/* 8- Imoveis e suas reservas*/
SELECT R.nome, R.entrada, R.saida, R.cidade FROM 
(SELECT * FROM reserva r JOIN imovel i ON r.fk_idimovel=i.id_imovel) AS R
