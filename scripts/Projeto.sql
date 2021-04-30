select * from acomodacao
select * from imovel
select * from imovel_acomodacao
select * from reserva
select * from tipo
select * from usuario

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

insert into reserva (id_reserva, fk_Idusuario, fk_Idimovel, entrada, saida, preco)
	values(4, 1, 1,'1-05-2021','03-05-2021', 1200.00);