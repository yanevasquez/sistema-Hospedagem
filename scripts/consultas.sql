/* Item 3.b- Criação e uso de objetos básicos */


/* Usuarios que não possui profissão cadastrada*/
SELECT * FROM usuario
WHERE profissao IS null

/* Exibir nomes dos usuarios com data de entrada e data de saida de suas reservas */
SELECT u.nome AS "Nome", r.entrada AS "Entrada", r.saida AS "Saída" 
FROM usuario u 
INNER JOIN reserva r ON u.id_usuario = r.fk_Idusuario

/* Exibir os destinos mais procurados e total de reservas */
SELECT imovel.cidade AS "Destinos mais Procurados", COUNT(reserva.fk_Idimovel) AS "Quantidade de reservas"
FROM reserva  
JOIN imovel ON reserva.fk_idimovel=imovel.id_imovel GROUP BY cidade

/* Exibir os nomes dos usuarios, valor das reservas e quantidade de reservas */
SELECT u.nome AS "Nome", COUNT(r.fk_idusuario) AS "Número de Reservas", SUM(r.preco) AS "Valor da reserva"
FROM usuario u
INNER JOIN reserva r ON u.id_usuario = r.fk_idusuario
GROUP BY u.id_usuario
ORDER BY COUNT(r.fk_idusuario) DESC



