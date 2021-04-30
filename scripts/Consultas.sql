
/Usuario onde profissão é nulo/
SELECT * FROM usuario
WHERE profissao IS null

/Nomes de usuarios com entrada e saida de suas reservas/
SELECT u.nome AS "Nome", r.entrada AS "Reserva", r.saida AS "Saída" 
FROM usuario u 
INNER JOIN reserva r ON u.id_usuario = r.fk_Idusuario

/Nome de usuarios com o numero de reservas e retorno em dinheiro do usuario/
SELECT u.nome AS "Nome", COUNT(r.fk_idusuario) AS "Número de Reservas", SUM(r.preco) AS "Retorno"
FROM usuario u
INNER JOIN reserva r ON u.id_usuario = r.fk_idusuario
GROUP BY u.id_usuario
ORDER BY COUNT(r.fk_idusuario) DESC

/Exibir os destinos mais procurados/
SELECT imovel.cidade, COUNT(reserva.fk_Idimovel) AS maisprocurados FROM reserva  
	JOIN imovel ON reserva.fk_idimovel=imovel.id_imovel GROUP BY cidade
