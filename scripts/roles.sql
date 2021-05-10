/* Item 3a.i -Privilegios e segurança: Criacao de 2 usuários */ 

/* Criacao do super usuário 01*/
CREATE ROLE usr_master LOGIN PASSWORD 'admin' 
SUPERUSER CREATEDB CREATEROLE;

/* Criacao do usuario administrador 02*/ 
CREATE ROLE usr_admin; 

/* Fornecendo algumas permissoes ao usuario administrador*/ 
GRANT SELECT, INSERT ON USUARIO, RESERVA, IMOVEL TO usr_admin;

/* Provendo acesso de consulta a visao para o usuario administrador */
GRANT SELECT on reservasPorMesAno TO usr_admin;

