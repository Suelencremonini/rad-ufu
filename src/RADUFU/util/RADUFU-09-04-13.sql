
SET datestyle TO 'dmy';
DROP TABLE IF EXISTS comprovante, atividade, multiplicador, tipo, categoria, professor;

CREATE TABLE professor(
professor_id	SERIAL NOT NULL,
professor_nome VARCHAR(60) NOT NULL,
professor_siape	VARCHAR(30) NOT NULL,
professor_senha	VARCHAR(40) NOT NULL,
UNIQUE(professor_siape),
CONSTRAINT const_professor_primary PRIMARY KEY(professor_id)
);

CREATE TABLE categoria(
categoria_id	SERIAL NOT NULL,
categoria_nome VARCHAR(60),
UNIQUE(categoria_nome),
CONSTRAINT const_categoria_primary PRIMARY KEY(categoria_id)
);

CREATE TABLE multiplicador(
multiplicador_id SERIAL NOT NULL,
multiplicador_nome VARCHAR (90),
UNIQUE(multiplicador_nome),
CONSTRAINT const_multiplicador_primary PRIMARY KEY(multiplicador_id)
);

CREATE TABLE tipo(
tipo_id SERIAL NOT NULL,
tipo_categoria INTEGER NOT NULL,
tipo_descricao VARCHAR(750) NOT NULL,
tipo_pontuacao SMALLINT NOT NULL,
tipo_pontuacaoreferencia	SMALLINT,
tipo_pontuacaolimite SMALLINT,
tipo_multiplicador	INTEGER NOT NULL,
CONSTRAINT const_tipo_primary PRIMARY KEY(tipo_id),
CONSTRAINT const_tipo_foreign FOREIGN KEY (tipo_categoria) REFERENCES categoria(categoria_id),
CONSTRAINT const_tipo_mult_foreign FOREIGN KEY (tipo_multiplicador) REFERENCES multiplicador(multiplicador_id)
);


CREATE TABLE atividade(
atividade_id	SERIAL NOT NULL,
atividade_tipo	INTEGER NOT NULL,
atividade_descricao VARCHAR(500) NOT NULL,
atividade_datainicio DATE,
atividade_datafim DATE,
atividade_multiplicador_valor FLOAT(8),
atividade_professor	INTEGER NOT NULL,
CONSTRAINT const_atividade_primary PRIMARY KEY(atividade_id),
CONSTRAINT const_atividade_foreign1 FOREIGN KEY (atividade_tipo) REFERENCES tipo(tipo_id),
CONSTRAINT const_atividade_foreign2 FOREIGN KEY (atividade_professor) REFERENCES professor(professor_id)
);

CREATE TABLE comprovante(
comprovante_id SERIAL NOT NULL,
comprovante_arquivo VARCHAR(500),
comprovante_atividade INTEGER NOT NULL,
CONSTRAINT const_comprovante_primary PRIMARY KEY(comprovante_id),
CONSTRAINT const_comprovante_foreign FOREIGN KEY(comprovante_atividade) REFERENCES atividade(atividade_id)
);


INSERT INTO categoria (categoria_nome) VALUES ('Atividades de Ensino');
INSERT INTO categoria (categoria_nome) VALUES ('Atividades de Orienta��o');
INSERT INTO categoria (categoria_nome) VALUES ('Produ��o Bibliogr�fica e Divulga��o');
INSERT INTO categoria (categoria_nome) VALUES ('Produ��o Art�stica');
INSERT INTO categoria (categoria_nome) VALUES ('Produ��o T�cnica');
INSERT INTO categoria (categoria_nome) VALUES ('Atividades de Pesquisa');
INSERT INTO categoria (categoria_nome) VALUES ('Atividades de Extens�o e Presta��o de Servi�os');
INSERT INTO categoria (categoria_nome) VALUES ('Licen�as, Situa��es Especiais e Qualifica��o');
INSERT INTO categoria (categoria_nome) VALUES ('Atividades Administrativas e Representa��es');
INSERT INTO categoria (categoria_nome) VALUES ('Outras Atividades');


INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/semestre por aula dada semanalmente');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/aula dada/semana');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/disciplina');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('ponto para cada grupo completo de 5 alunos acima de 45');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('ponto para cada grupo completo de 4 alunos acima de 12');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('ponto para cada grupo completo de 3 alunos acima de 9');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('ponto para cada grupo completo de 2 alunos acima de 6');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('ponto para cada grupo completo de 3 alunos acima de 8');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('ponto para cada aluno por aula dada/semana');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/aluno');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/orienta��o');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/evento');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/semestre');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/trabalho');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/resumo');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/publica��o');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/tema');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/tema limitado a 20 pontos/semestre');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/premia��o/trabalho ou evento');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/publica��o limitado a um por ano');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/publica��o limitado em 120 pontos/ano');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/obra');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/cap�tulo ou artigo');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/exposi��o');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/dire��o');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/autoria');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/adapta��o ou trabalho');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/�pera ou musical');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/hora - m�x. de 30 horas/obra');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/maquete');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/participa��o');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/parecer');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/registro');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/patente');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/relat�rio');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('ponto/hora-aula; limite de 40 pontos por semestre');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('1/180 da pontua��o de refer�ncia  por dia de afastamento');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('1/180 da pontua��o de refer�ncia  por dia de readapta��o');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('100% da pontua��o de refer�ncia');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('50% da pontua��o de refer�ncia');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('100% pontua��o refer�ncia/semestre');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('70% pontua��o refer�ncia/semestre');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('50% pontua��o refer�ncia/semestre');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('40% pontua��o refer�ncia/semestre');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('60% pontua��o refer�ncia/semestre');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/coordenadoria-curadoria/semestre');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/coordena��o/semestre');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/Curso');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/semestre/projeto');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/comiss�o/semestre');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/participa��o/semestre');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/representa��o/semestre');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/Conselho/semestre');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/presid�ncia');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('1/180 da pontua��o do cargo/dia/semestre');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('pontos/aula dada/semana/semestre');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('ponto para cada grupo de 3 alunos acima de 8');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('ponto/hora-aula; limite de 30 pontos');
INSERT INTO multiplicador (multiplicador_nome) VALUES ('ponto/hora; limite de 30 pontos');

--ATIVIDADES DE ENSINO 
--1
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (1,10,1,'Aula te�rica ou pr�tica de disciplinas ministradas na Educa��o B�sica, na Educa��o Profissional, em cursos de gradua��o ou p�s-gradua��o stricto e lato sensu da UFU, sem remunera��o complementar, aprovadas pelo Conselho da Unidade. Para disciplinas ministradas por mais de um docente, a pontua��o dever� ser atribu�da ao docente de acordo com a carga hor�ria ministrada pelo mesmo. Turmas adicionais da mesma disciplina ministradas pelo docente ser�o pontuadas nos itens 02 e 03.');
--2
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (1,10,2,'Aula te�rica ou pr�tica para turmas adicionais da mesma disciplina, enquadrada na Situa��o 1 (ver OBS.), ou ministrada pelo mesmo docente para Cursos oferecidos em turnos distintos.');
--3
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (1,5,2,'Aula te�rica ou pr�tica para turmas adicionais da mesma disciplina, ministrada pelo mesmo docente, e no mesmo Curso, enquadrada na Situa��o 2 (ver OBS.).');
--4
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (1,10,3,'Aula de gradua��o oferecida em regime especial, aprovado pelo Conselho da Unidade.');
--5
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (1,1,4,'Aula te�rica para turmas com mais de 45 alunos, equivalente � turma padr�o para este item.');
--6
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (1,1,5,'Aula pr�tica de Ci�ncias Humanas, Ci�ncias Sociais Aplicadas, Letras e Ling��stica para turmas com mais de 12 alunos (exceto M�sica), equivalente � turma padr�o para este item.');
--7
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (1,1,6,'Aula pr�tica de Ci�ncias Exatas e da Terra, Ci�ncias Agr�rias, Ci�ncias Biol�gicas, Engenharias e Ci�ncias da Sa�de (exceto Medicina, Enfermagem e Odontologia) para turmas com mais de 9 alunos, equivalente � turma padr�o para este item.');
--8
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (1,1,7,'Aula pr�tica de Medicina, Enfermagem, Odontologia, M�sica, mestrado e doutorado para turmas com mais de 6 alunos, equivalente � turma padr�o para este item.');
--9
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (1,1,8,'Aula pr�tica de cursos de p�s-gradua��o lato sensu, sem remunera��o suplementar, para turmas com mais de 8 alunos, equivalente � turma padr�o para este item.');
--10
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (1,0.05,9,'N�mero de alunos por disciplina inclu�da no item 01.');

--ATIVIDADES DE ORIENTA��O
--11
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (2,4,10,'Orienta��o de alunos de gradua��o e da educa��o profissional em atividades curriculares de ensino (Est�gio Supervisionado, Est�gio Profissionalizante, Ensino Vivenciado, Monografia de Gradua��o, Assist�ncia Judici�ria e similares). A comprova��o dever� ser fornecida pela Coordena��o do Curso na qual o aluno encontra-se matriculado. � permitida a contagem at� o limite de quatro semestres de orienta��o a um mesmo aluno. Somente ser�o pontuadas as atividades de orienta��o com dura��o superior a tr�s meses.');
--12
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (2,4,10,'Orienta��o de alunos da Educa��o B�sica, da Educa��o Profissional ou da gradua��o em projetos de ensino, pesquisa e extens�o com bolsa de Inicia��o Cient�fica (PIBEG, PEIC, PET e similares). A comprova��o dever� ser pelo �rg�o de fomento do qual o aluno � bolsista. Somente ser�o pontuadas as atividades de orienta��o com dura��o superior a tr�s meses.');
--13
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (2,3,10,'Orienta��o de alunos da Educa��o B�sica, da Educa��o Profissional ou da gradua��o em projetos de ensino, pesquisa e extens�o sem bolsa de Inicia��o Cient�fica (projetos sem bolsa registrados na Unidade Administrativa em quest�o e similares). A comprova��o dever� ser fornecida pelas Diretorias competentes da UFU. Somente ser�o pontuadas as atividades de orienta��o com dura��o superior a tr�s meses.');
--14
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (2,10,10,'Orienta��o de Disserta��o de Mestrado. � permitida a contagem at� o limite de quatro semestres de orienta��o a um mesmo aluno. A comprova��o dever� ser feita pela Coordena��o do Programa de P�s-gradua��o no qual o aluno encontra-se matriculado.');
--15
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (2,5,10,'Co-orienta��o de Disserta��o de Mestrado. � permitida a contagem at� o limite de quatro semestres de co-orienta��o a um mesmo aluno. A comprova��o dever� ser feita pela Coordena��o do Programa de P�s-gradua��o no qual o aluno encontra-se matriculado.');
--16
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (2,15,10,'Orienta��o de Tese de Doutorado. � permitida a contagem at� o limite de oito semestres de orienta��o a um mesmo aluno. A comprova��o dever� ser feita pela Coordena��o do Programa de P�s-gradua��o no qual o aluno encontra-se matriculado.');
--17
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (2,10,10,'Co-orienta��o de Tese de Doutorado. � permitida a contagem at� o limite de oito semestres de co-orienta��o a um mesmo aluno. A comprova��o dever� ser feita pela Coordena��o do Programa de P�s-gradua��o no qual o aluno encontra-se matriculado.');
--18
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (2,5,11,'Orienta��o de graduados em Cursos de Educa��o profissional ou permanente. As atividades dever�o ser comprovadas pela Pr�-Reitoria de Pesquisa e P�sgradua��o � PROPP. Somente ser�o pontuadas as atividades de orienta��o com dura��o superior a quatro meses.');
--19
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (2,5,10,'Orienta��o de Monografia de Curso de Especializa��o. Somente ser�o pontuadas as atividades de orienta��o com dura��o superior a quatro meses. A atividade ser� comprovada por declara��o do Coordenador de Curso ou do Diretor da Unidade.');
--20
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (2,2,10,'Orienta��o de Monitores. � permitida a contagem at� o limite de quatro semestres de orienta��o a um mesmo aluno. A monitoria dever� ser oficializada pelos �rg�os competentes da UFU e aprovada pelo Conselho da Unidade. Somente ser�o pontuadas as atividades de orienta��o com dura��o igual ou superior a quatro meses.');
--21
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (2,4,12,'Orienta��o ou supervis�o de alunos da educa��o b�sica e profissional, em exposi��es, congressos, semin�rios e encontros. Ser�o pontuadas as atividades aprovadas pelo Conselho da Unidade Especial de Ensino e comprovadas por declara��o do Diretor.');
--22
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (2,4,13,'Orienta��o educacional na educa��o b�sica, em atividades de recreio orientado. Ser�o pontuadas as atividades comprovadas por meio de Portaria de nomea��o do docente.');

--PRODU��O BIBLIOGR�FICA E DIVULGA��O
--23
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,120,14,'Artigo t�cnico-cient�fico publicado em peri�dico indexado internacional. Ser�o pontuadas as publica��es com n�mero de p�ginas superior a dois, comprovadas por c�pia da folha de rosto do meio de divulga��o do artigo e da primeira p�gina do mesmo. Publica��es com n�mero de p�ginas inferior a tr�s ser�o pontuadas desde que o peri�dico seja classificado como QUALIS A ou B.');
--24
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,100,14,'Artigo t�cnico-cient�fico publicado em peri�dico indexado nacional. Ser�o pontuadas as publica��es com n�mero de p�ginas superior a dois, comprovadas por c�pia da folha de rosto do meio de divulga��o do artigo e da primeira p�gina do mesmo. Publica��es com n�mero de p�ginas inferior a tr�s ser�o pontuadas desde que o peri�dico seja classificado como QUALIS A ou B.');
--25
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,40,14,'Artigo t�cnico-cient�fico publicado em peri�dico n�o-indexado, com corpo de revisores. Ser�o pontuadas as publica��es com n�mero de p�ginas superior a dois, comprovadas por c�pia da folha de rosto do meio de divulga��o do artigo e da primeira p�gina do mesmo.');
--26
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,60,14,'Publica��o de trabalho completo em anais de reuni�o cient�fica internacional, com corpo de revisores. Reuni�es cient�ficas internacionais realizadas em territ�rio nacional poder�o ser pontuadas. Ser�o pontuadas as publica��es com n�mero de p�ginas superior a dois, comprovadas por c�pia da folha de rosto do meio de divulga��o do artigo e da primeira p�gina do mesmo.');
--27
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,40,14,'Publica��o de trabalho completo em anais de reuni�o cient�fica nacional, com corpo de revisores. Ser�o pontuadas as publica��es com n�mero de p�ginas superior a dois, comprovadas por c�pia da folha de rosto do meio de divulga��o do artigo e da primeira p�gina do mesmo.');
--28
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,10,14,'Publica��o de resumo em anais de reuni�o cient�fica internacional. Reuni�es cient�ficas internacionais realizadas em territ�rio nacional poder�o ser pontuadas. Ser�o pontuadas as publica��es comprovadas por c�pia do resumo e da folha de rosto do meio de divulga��o do resumo.');
--29
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,5,15,'Publica��o de resumo em anais de reuni�o cient�fica nacional, peri�dico ou boletim t�cnico. Ser�o pontuadas as publica��es comprovadas por c�pia do resumo e da folha de rosto do meio de divulga��o do resumo.');
--30
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,5,16,'Publica��o individual de cr�tica, pref�cio de obras especializadas, espet�culos ou exposi��es. Ser�o pontuadas aquelas comprovadas por c�pia da publica��o ou folha de rosto do meio de divulga��o.');
--31
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,10,16,'Publica��o individual de resenha. Ser�o pontuadas as publica��es comprovadas por c�pia da folha de rosto do meio de divulga��o e da primeira p�gina da publica��o.');
--32
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,10,14,'Apresenta��o de trabalho ou mostra documental em reuni�o cient�fica internacional. Ser�o pontuados apenas os trabalhos apresentados pelo docente, comprovados por certificado assinado pelo Coordenador ou pelo Presidente do evento cient�fico. Reuni�es cient�ficas internacionais realizadas em territ�rio nacional poder�o ser pontuadas.');
--33
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,5,14,'Apresenta��o de trabalho ou mostra documental em reuni�o cient�fica nacional. Ser�o pontuados apenas os trabalhos apresentados pelo docente, comprovados por certificado assinado pelo Coordenador ou pelo Presidente do evento cient�fico.');
--34
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,15,17,'Palestras e confer�ncias proferidas, minicursos ministrados, participa��o em pain�is de debate ou mesas redondas em reuni�es cient�ficas promovidas por associa��es ou sociedades cient�ficas ou associa��es esportivas nacionais e internacionais. Somente ser�o pontuadas as participa��es devidamente comprovadas por certificado do evento cient�fico.');
--35
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,5,18,'Palestras e confer�ncias proferidas, minicursos ministrados, participa��o em mesas redondas ou em pain�is de debate em reuni�es cient�ficas n�o promovidas por associa��es ou sociedades cient�ficas. Somente ser�o pontuadas as participa��es devidamente comprovadas por certificado do evento cient�fico.');
--36
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,5,18,'Palestras e confer�ncias proferidas, minicursos ministrados, participa��o em mesas redondas ou em pain�is de debate em eventos acad�micos isolados e eventos sem apresenta��o de trabalho. Somente ser�o pontuadas as participa��es devidamente comprovadas por certificado do evento.');
--37
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,30,19,'Premia��o ou men��o honrosa de trabalhos art�sticos, arquitet�nicos, cient�ficos, liter�rios em eventos cient�ficos, esportivos e culturais. O trabalho dever� ser pontuado uma �nica vez e a premia��o ou men��o honrosa dever� ser comprovada.');
--38
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,20,20,'Monografia defendida em curso de especializa��o. A comprova��o ser� feita por declara��o da Coordena��o do Curso de Especializa��o.');
--39
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,40,20,'Disserta��o de Mestrado defendida pelo docente. A comprova��o ser� feita por declara��o da Coordena��o do Programa de P�sgradua��o no qual o docente encontra-se matriculado.');
--40
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,80,20,'Tese de Doutorado ou Livre Doc�ncia defendida pelo docente. A comprova��o ser� feita por declara��o da Coordena��o do Programa de P�sgradua��o no qual o docente encontra-se matriculado.');
--41
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,120,21,'Publica��o de livro cultural ou t�cnico no exterior. S� ser�o aceitos livros publicados por Editora com Conselho Editorial. Ser�o pontuadas as publica��es comprovadas por c�pia da folha de rosto do meio de divulga��o e da ficha catalogr�fica.');
--42
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,100,21,'Publica��o de livro cultural ou t�cnico no pa�s. S� ser�o aceitos livros publicados por Editora com Conselho Editorial. Ser�o pontuadas as publica��es comprovadas por c�pia da folha de rosto do meio de divulga��o e da ficha catalogr�fica.');
--43
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,40,22,'Publica��o de cap�tulo de livro cultural ou t�cnico no exterior, desde que n�o inserido em anais de congressos ou eventos. S� ser�o aceitos livros publicados por Editora com Conselho Editorial. Ser�o pontuadas as publica��es comprovadas por c�pia da folha de rosto do meio de divulga��o e da ficha catalogr�fica.');
--44
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,30,22,'Publica��o de cap�tulo de livro cultural ou t�cnico no Pa�s, desde que n�o inserido em anais de congressos ou eventos. S� ser�o aceitos livros publicados por Editora com Conselho Editorial. Ser�o pontuadas as publica��es comprovadas por c�pia da folha de rosto do meio de divulga��o e da ficha catalogr�fica.');
--45
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,30,23,'Editora��o de livros, de anais de eventos, cole��es, peri�dicos ou dossi�s de peri�dicos. Ser�o pontuadas as publica��es comprovadas por c�pia da folha de rosto do meio de divulga��o e da ficha catalogr�fica.');
--46
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,30,23,'Tradu��o de pe�as teatrais, de �peras encenadas ou livros. A autoria de cada trabalho dever� ser devidamente comprovada. Caso o trabalho tenha sido publicado, pontuar apenas os itens relativos a publica��es; no caso da obra ter sido publicada e apresentada, considerar somente a publica��o. Ser�o pontuadas as tradu��es comprovadas por c�pia da folha de rosto do meio de divulga��o e das primeiras p�ginas da mesma.');
--47
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (3,10,24,'Tradu��o de cap�tulo de livros ou artigos em peri�dicos. Ser�o pontuadas as tradu��es comprovadas por c�pia da folha de rosto do meio de divulga��o e das primeiras p�ginas da publica��o.');

--PRODU��O ART�STICA
--48
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,100,25,'Exposi��o art�stica nacional individual de obras art�sticas in�ditas. Ser�o pontuadas as exposi��es devidamente comprovadas por meio de cat�logos. Cada exposi��o ser� pontuada uma �nica vez, desde que autorizada e comprovada pela Unidade.');
--49
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,40,25,'Exposi��o art�stica nacional coletiva de obras art�sticas in�ditas. Ser�o pontuadas as exposi��es devidamente comprovadas por meio de cat�logos. Cada exposi��o ser� pontuada uma �nica vez, desde que autorizada e comprovada pela Unidade.');
--50
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,120,25,'Exposi��o art�stica internacional individual de obras art�sticas in�ditas. Ser�o pontuadas as exposi��es devidamente comprovadas por meio de cat�logos. Cada exposi��o ser� pontuada uma �nica vez, desde que autorizada e comprovada pela Unidade.');
--51
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,60,25,'Exposi��o art�stica internacional coletiva de obras art�sticas in�ditas. Ser�o pontuadas as exposi��es devidamente comprovadas por meio de cat�logos. Cada exposi��o ser� pontuada uma �nica vez, desde que autorizada e comprovada pela Unidade.');
--52
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,60,23,'Participa��o como solista em concertos, recitais ou grava��es. A participa��o ser� pontuada uma �nica vez, independente do n�mero de apresenta��es, desde que autorizada e comprovada pela Unidade.');
--53
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,20,23,'Participa��o como n�o solista em concertos, recitais ou grava��es. A participa��o ser� pontuada uma �nica vez, independente do n�mero de apresenta��es, desde que autorizada e comprovada pela Unidade.');
--54
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,120,26,'Dire��o de filmes, v�deos, pe�as teatrais, �peras e espet�culos de dan�a realizados e/ou encenados em eventos art�stico-culturais nacionais ou internacionais. A participa��o ser� pontuada uma �nica vez, independente do n�mero de apresenta��es, desde que autorizada e comprovada pela Unidade.');
--55
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,90,27,'Autoria de pe�as teatrais, roteiros, �peras, concertos, composi��es musicais, trilha sonora, cenografia, figurino, ilumina��o e/ou coreografias integrais apresentadas e/ou gravadas. Os trabalhos art�sticos poder�o ser pontuados uma �nica vez, independente do n�mero de apresenta��es, desde que autorizados e comprovados pela Unidade.');
--56
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,20,28,'Adapta��o de pe�a teatral e/ou �pera encenada e/ou autoria de trabalho na �rea de comunica��o visual publicada. Os trabalhos art�sticos poder�o ser pontuados uma �nica vez, independente do n�mero de apresenta��es, desde que autorizados e comprovados pela Unidade.');
--57
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,60,29,'Reg�ncia de �pera ou espet�culo musical em eventos art�stico-culturais nacionais ou internacionais. Cada trabalho poder� ser pontuado uma �nica vez, independente do n�mero de apresenta��es, desde que aprovado e comprovado pela Unidade.');
--58
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,20,23,'Transcri��o e/ou arranjo de obras musicais gravadas ou publicadas. Cada trabalho poder� ser pontuado uma �nica vez, independente do n�mero de apresenta��es ou execu��es, desde que aprovadas e comprovadas pela Unidade.');
--59
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,30,23,'Interpreta��o de pap�is centrais em �peras, espet�culos teatrais ou de dan�a. A participa��o ser� pontuada uma �nica vez, independente do n�mero de apresenta��es, desde que aprovada e comprovada pela Unidade.');
--60
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,10,23,'Interpreta��es de pap�is secund�rios em �peras, espet�culos teatrais ou de dan�a. A participa��o ser� pontuada uma �nica vez, independente do n�mero de apresenta��es, desde que aprovada e comprovada pela Unidade.');
--61
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,2,30,'Restaura��o de obras art�sticas de comprovado valor hist�rico. Ser� pontuada a atividade aprovada e comprovada pela Unidade.');
--622
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,40,26,'Dire��o de leitura dram�tica ou de pe�a radiof�nica. A participa��o ser� pontuada uma �nica vez, independente do n�mero de apresenta��es desde que aprovada e comprovada pela Unidade.');
--63
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,2,12,'Apresenta��es art�stico-culturais em eventos isolados. Ser� pontuada a atividade aprovada e comprovada pela Unidade.');
--64
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (4,20,31,'Maquetes f�sicas ou digitais. Cada maquete poder� ser pontuada uma �nica vez, desde que aprovada e comprovada pela Unidade.');

--PRODU��O T�CNICA
--65
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,10,32,'Membro de Comiss�o Julgadora de eventos cient�ficos, art�sticos, culturais, esportivos, t�cnicos e de banca de qualifica��o para o exerc�cio profissional. Ser�o pontuadas as participa��es comprovadas com certificado do evento.');
--66
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,10,13,'Membro de Comiss�o Organizadora de reuni�es cient�ficas, art�sticas, culturais, t�cnicas e esportivas. Ser�o pontuadas as participa��es comprovadas por declara��o do Coordenador da Comiss�o Organizadora ou do Diretor da Unidade respons�vel pela organiza��o do evento.');
--67
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,5,33,'Parecer ad hoc prestado a editoras, revistas especializadas e �rg�os de fomento, comprovado por declara��o da institui��o solicitante, resguardado o sigilo e demais considera��es �ticas associadas a pareceres ad hoc.');
--68
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,15,13,'Coordena��o de Comiss�o Organizadora de reuni�es cient�ficas, art�sticas, culturais, t�cnicas e esportivas, promovidas por associa��es ou sociedades cient�ficas ou art�stico-culturais, comprovada por declara��o da institui��o solicitante.');
--69
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,20,13,'Diretor-geral ou Editor Chefe de revista cient�fica ou art�stica. Ser�o pontuadas as participa��es devidamente comprovadas pela Revista.');
--70
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,10,13,'Membro de Conselho ou Corpo Editorial de revista cient�fica, art�stica ou de Editoras. Este item n�o contempla Conselho Editorial composto pelos consultores ad hoc, pois essa atividade j� est� contemplada em outro item. Ser�o pontuadas as participa��es devidamente comprovadas pela Revista ou Editora.');
--71
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,4,32,'Membro titular de banca de defesa de projetos, est�gio supervisionado e de monografias de gradua��o. Ser�o pontuadas as participa��es comprovadas por meio de declara��o fornecida pelo Coordenador de Curso de Gradua��o ou pelo Diretor da Unidade.');
--72
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,5,32,'Membro titular de banca de defesa de Monografia de P�s-gradua��o lato sensu. Ser�o pontuadas as participa��es comprovadas por declara��o fornecida pelo Coordenador de Curso de P�s-gradua��o.');
--73
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,10,32,'Membro titular de banca de exame de qualifica��o de Mestrado ou Doutorado. Ser�o pontuadas as participa��es comprovadas por declara��o fornecida pelo Coordenador de Curso de P�s-gradua��o.');
--74
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,15,32,'Membro titular de banca de Disserta��o de Mestrado. Ser�o pontuadas as participa��es comprovadas por declara��o fornecida pelo Coordenador de Curso de P�s-gradua��o.');
--75
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,20,32,'Membro titular de banca de Tese de Doutorado. Ser�o pontuadas as participa��es comprovadas por declara��o fornecida pelo Coordenador de Curso de P�s-gradua��o.');
--76
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,80,34,'Patente ou cultivar com pedido de registro comprovado (com titularidade ou co-titularidade da UFU).');
--77
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,150,35,'Patente ou cultivar transferida (com titularidade ou co-titularidade da UFU).');
--78
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,40,34,'Programa de computador com registro no INPI (com titularidade ou cotitularidade da UFU).');
--79
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,60,34,'Programa de computador transferido (com titularidade ou co-titularidade da UFU).');
--80
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,40,34,'Desenho industrial com registro no INPI (com titularidade ou co-titularidade da UFU).');
--81
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,60,34,'Desenho industrial transferido (com titularidade ou co-titularidade da UFU).');
--82
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,20,36,'Relat�rio final de pesquisa com financiamento externo ou interno. Os relat�rios elaborados pelos discentes n�o dever�o ser pontuados. Ser�o pontuados os relat�rios comprovadamente submetidos e aprovados pelo �rg�o de fomento.');
--83
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (5,10,36,'Relat�rio final de pesquisa sem financiamento, com registro na PROPP. Os relat�rios elaborados pelos discentes n�o dever�o ser pontuados. Ser�o pontuados os relat�rios comprovadamente submetidos e aprovados pela PROPP.');

--ATIVIDADES DE PESQUISA
--84
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (6,30,13,'Coordena��o de projetos de ensino ou pesquisa com financiamento externo. Ser�o pontuadas as coordena��es, comprovadas por documento de aprova��o do projeto pelo �rg�o de fomento.');
--85
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (6,15,13,'Coordena��o de projetos de ensino ou pesquisa com financiamento interno e registrado na PROPP.');
--86
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (6,10,13,'Coordena��o de projetos de ensino ou pesquisa sem financiamento e registrado na PROPP.');
--87
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (6,5,13,'Membro de equipe de projetos de ensino ou pesquisa com financiamento externo ou interno. Ser�o pontuadas as participa��es comprovadas por declara��o do Coordenador do projeto ou Diretor da Unidade Acad�mica ou por documento espec�fico do �rg�o financiador.');
--88
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (6,3,13,'Membro de equipe de projetos de ensino ou pesquisa sem financiamento e registrado na PROPP. Ser�o pontuadas as participa��es comprovadas por declara��o do Coordenador do projeto ou Diretor da Unidade Acad�mica.');

--ATIVIDADES DE EXTENS�O E PRESTA��O DE SERVI�OS
--89
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (7,1,37,'Curso de extens�o ministrado com aprova��o do Conselho da Unidade e registrado na Pr�-Reitoria de Extens�o, Cultura e Assuntos Estudantis � PROEX, sem remunera��o complementar.');
--90
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (7,0.5,37,'Consultoria, assessoria, per�cia ou sindic�ncia realizada e aprovada pela Unidade, sem remunera��o complementar.');
--91
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (7,30,13,'Coordena��o de projetos de extens�o com financiamento externo e sem remunera��o complementar. Ser�o pontuadas as coordena��es com dura��o igual ou superior a seis meses, comprovadas por documento de aprova��o do projeto pelo �rg�o de fomento.');
--92
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (7,15,13,'Coordena��o de projetos de extens�o com financiamento interno, registrado na PROEX e sem remunera��o complementar. Ser�o pontuadas as coordena��es com dura��o igual ou superior a tr�s meses.');
--93
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (7,10,13,'Coordena��o de projetos de extens�o sem financiamento, registrado na PROEX e sem remunera��o complementar. Ser�o pontuadas as coordena��es com dura��o igual ou superior a tr�s meses.');
--94
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (7,5,13,'Membro de equipe de projetos de extens�o com financiamento externo ou interno e sem remunera��o complementar. Ser�o pontuadas as participa��es comprovadas por declara��o do Coordenador do projeto ou Diretor da Unidade Acad�mica.');
--95
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (7,3,15,'Membro de equipe de projetos de extens�o sem financiamento, registrados na PROEX e sem remunera��o complementar. Ser�o pontuadas as participa��es comprovadas por declara��o do Coordenador do projeto ou Diretor da Unidade Acad�mica.');
--96
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (7,20,13,'Atua��o na Assist�ncia Judici�ria. A atividade dever� ser autorizada pelo Conselho da Unidade, comprovada por declara��o da Assist�ncia Judici�ria com o acordo do Diretor e dever� ter dura��o m�nima de tr�s meses.');

--LICEN�AS, SITUA��ES ESPECIAIS E QUALIFICA��O ****
--97
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (8,0,0.005,38,'Licen�as de concess�o obrigat�ria (pr�mio, gestante, sa�de e outras) ou capacita��o. A comprova��o da licen�a ser� feita por declara��o dos �rg�os competentes da UFU.');
--98
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (8,0,0.005,39,'Readapta��o funcional. A comprova��o ser� feita por declara��o dos �rg�os competentes da UFU.');
--99
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (8,0,0.005,38,'Situa��o especial para o docente servidor cedido para exerc�cio de cargo de natureza especial; DAS 6, 5 ou 4, ou cargo equivalente na Administra��o P�blica. A comprova��o da situa��o especial ser� feita por declara��o dos �rg�os competentes da UFU.');
--100
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (8,0,1,40,'Afastamento integral para cursar p�s-gradua��o em n�vel de Mestrado, Doutorado e P�s-doutorado, aprovado pelo Conselho da Unidade e comprovado por ata da reuni�o que concedeu o afastamento ou declara��o do Diretor e relat�rio aprovado pelo Conselho da Unidade.');
--101
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (8,0,0.5,41,'Afastamento parcial para cursar p�s-gradua��o em n�vel de Mestrado, Doutorado e P�s-doutorado. Aprovado pela Unidade e comprovado por ata da reuni�o que concedeu o afastamento ou declara��o do Diretor e relat�rio aprovado pelo Conselho da Unidade.');
--102
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (8,0,0.005,38,'Afastamento tempor�rio, inferior a 120 dias, para est�gio t�cnico, aperfei�oamento ou miss�o de trabalho. Aprovado pela Unidade e comprovado por ata da reuni�o que concedeu o afastamento ou declara��o do Diretor e relat�rio aprovado pelo Conselho da Unidade.');

--ATIVIDADES ADMINISTRATIVAS E REPRESENTA��ES
--103
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (9,0,1,42,'Reitor. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses, comprovadas por documento de homologa��o do cargo.');
--104
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (9,0,1,42,'Vice-Reitor. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses, comprovadas por documento de homologa��o do cargo.');
--105
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (9,0,0.7,43,'Pr�-Reitor. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses, comprovadas por documento de homologa��o do cargo.');
--106
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (9,0,0.7,43,'Diretor de Unidade. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses, comprovadas por documento de homologa��o do cargo.');
--107
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (9,0,0.5,44,'Coordenador ou Chefe de Departamento que recebe fun��o gratificada. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses, comprovadas por documento de homologa��o do cargo.');
--108
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (9,0,0.7,43,'Coordenador de Curso de Gradua��o ou de Curso de P�s-gradua��o stricto sensu ou da Educa��o Profissional. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses, comprovadas por documento de homologa��o do cargo.');
--109
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (9,0,0.4,45,'Coordena��o de Curso de P�s-gradua��o lato sensu, sem remunera��o complementar. A atividade ser� pontuada se devidamente comprovada por declara��o do Diretor ou ata da reuni�o do Conselho da Unidade. Ser�o pontuadas as atividades com dura��o m�nima de tr�s meses.');
--110
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (9,0,0.6,46,'Coordena��o pedag�gica de �reas de conhecimento de Unidade Especial de Ensino. Ser�o pontuadas as atividades com dura��o superior a tr�s meses e comprovadas por Portaria do Reitor.');
--111
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (9,0,0.5,44,'Diretor de Comunica��o Social. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses, comprovadas por documento de homologa��o do cargo.');
--112
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (9,0,0.5,44,'Chefe de Gabinete do Reitor. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses, comprovadas por documento de homologa��o do cargo.');
--113
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (9,0,0.7,43,'Diretor Executivo das Funda��es Universit�rias. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses, comprovadas por documento de homologa��o do cargo.');
--114
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (9,0,0.7,43,'Diretor de Hospital de Cl�nicas ou de Hospital Veterin�rio ou de Hospital Odontol�gico. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses, comprovadas por documento de homologa��o do cargo.');
--115
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (9,0,0.5,44,'Diretor de Pr�-Reitoria. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses, comprovadas por documento de homologa��o do cargo.');
--116
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (9,0,0.5,44,'Assessor (CD, FG1, FG2). Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses, comprovadas por documento de homologa��o do cargo.');
--117
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (9,0,0.6,46,'Assessor de Unidade Especial de Ensino (CD, FG1, FG2). Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses, comprovadas por documento de homologa��o do cargo.');

--OUTRAS ATIVIDADES
--118
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,10,13,'Membro de diretoria de �rg�os de classe, de organiza��es de fomento e de organiza��es n�o governamentais de express�o reconhecida, desde que esteja relacionado � sua atividade profissional e cuja participa��o seja aprovada pelo Conselho da Unidade. Ser�o pontuadas as participa��es com dura��o m�nima de tr�s meses, comprovadas por ata da reuni�o de aprova��o no Conselho da Unidade.');
--119
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,5,13,'Representante oficial da Unidade junto � Biblioteca, em efetivo exerc�cio. Ser�o pontuadas as atividades de representa��o com dura��o m�nima de tr�s meses, comprovadas por documento de homologa��o da representa��o ou por declara��o da Biblioteca.');
--120
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,10,32,'Participa��o como curador de exposi��es art�sticas locais e regionais. Ser�o pontuadas as participa��es devidamente aprovadas pela Unidade e comprovadas pela organiza��o do evento.');
--121
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,20,32,'Participa��o como curador de exposi��es art�sticas nacionais. Ser�o pontuadas as participa��es devidamente aprovadas pela Unidade e comprovadas pela organiza��o do evento.');
--122
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,30,32,'Participa��o como curador de exposi��es art�sticas internacionais. Ser�o pontuadas as participa��es devidamente aprovadas pela Unidade e comprovadas pela organiza��o do evento.');
--123
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,10,32,'Participa��o, em evento de n�vel local ou regional, como chefe de delega��o, membro de comiss�es t�cnicas e membro de comiss�es de avalia��es e classifica��o de equipes esportivas. Ser�o pontuadas as participa��es devidamente aprovadas pela Unidade e comprovadas por documento oficial da institui��o promotora e participante do Sistema Nacional de Esporte.');
--124
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,20,32,'Participa��o, em evento de n�vel nacional, como chefe de delega��o, membro de comiss�es t�cnicas e membro de comiss�es de avalia��es e classifica��o de equipes esportivas. Ser�o pontuadas as participa��es devidamente aprovadas pela Unidade e comprovadas por documento oficial da institui��o promotora e participante do Sistema Nacional de Esporte.');
--125
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,30,32,'Participa��o, em evento de n�vel internacional, como chefe de delega��o, membro de comiss�es t�cnicas e membro de comiss�es de avalia��es e classifica��o de equipes esportivas. Ser�o pontuadas as participa��es devidamente aprovadas pela Unidade e comprovadas por documento oficial da institui��o promotora e participante do Sistema Nacional de Esporte.');
--126
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,20,32,'Banca de Concursos P�blicos. A atividade de membro efetivo ser� comprovada por documenta��o emitida pelo Diretor da Unidade ou pela Institui��o P�blica.');
--127
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,10,32,'Banca de Processos Seletivos. Ser�o pontuadas as participa��es em processos seletivos de docentes com contrato tempor�rio de trabalho de Universidades, de funcion�rios de Funda��es Universit�rias P�blicas. A atividade ser� comprovada por documenta��o emitida pelo Diretor da Unidade ou pela Institui��o P�blica.');
--128
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,5,32,'Banca de Processos Seletivos de alunos para p�s-gradua��o stricto sensu e de alunos transferidos de outras institui��es para a UFU. A atividade ser� comprovada por documenta��o emitida pelo Diretor da Unidade ou pela Institui��o P�blica.');
--129
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,10,47,'Coordena��o de laborat�rios, N�cleos de Pesquisa, da Cl�nica Psicol�gica, da Cl�nica Odontol�gica, do Setor de Pr�tica Desportiva e do Setor de Oficina Mec�nica. Ser�o pontuadas as coordena��es oficializadas por Ordem de Servi�o ou Portaria do Diretor da Unidade, com dura��o superior a tr�s meses.');
--130
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,30,48,'Coordena��o de Est�gio Supervisionado, de atividade pr�tica curricular profissionalizante e/ou Pr�tica de Ensino e Coordena��o geral de Internato. Ser�o pontuadas as atividades com dura��o superior a tr�s meses, nomeadas pelo Diretor da Unidade. (Somente um docente por Curso)');
--131
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,30,13,'Tutoria do PET.');
--132
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,5,49,'Conclus�o de curso de aperfei�oamento. Ser�o pontuados os Cursos com o m�nimo de 180 horas, comprovado por declara��o do Coordenador do Curso de Aperfei�oamento.');
--133
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,5,13,'Hor�rio de atendimento semanal �s fam�lias de alunos da Educa��o B�sica. Ser�o pontuados os docentes que comprovarem a presen�a em pelo menos 75% dos dias previstos no semestre, por meio de lista de presen�a organizada pela Dire��o da Escola e acompanhada pelas �reas de Ensino, comprovadas por declara��o do Diretor.');
--134
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,2,32,'Participa��o em Conselhos de Avalia��o Discente (Conselho de Classe) das Unidades Especiais de Ensino, comprovada por meio de Declara��o da Dire��o da U.E.E.');
--135
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,20,13,'Gerente. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses e comprovadas por documentos de homologa��o do cargo.');
--136
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,15,13,'Chefe de setor e de servi�o m�dico-odontol�gico. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses e comprovadas por documentos de homologa��o do cargo.');
--137
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,20,13,'Coordena��o de �rg�o complementar. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses e comprovadas por documentos de nomea��o para o cargo.');
--138
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,40,13,'Coordena��o da Resid�ncia M�dica. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses e comprovadas por documentos de homologa��o do cargo.');
--139
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,20,13,'Coordena��o de Programa de Educa��o Continuada. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses e comprovadas por documentos de homologa��o do cargo.');
--140
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,5,50,'Coordenador de Projeto de Interc�mbio Internacional, nomeado por Portaria. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses e comprovadas por documentos de homologa��o do cargo.');
--141
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,10,51,'Membro de Comiss�o Permanente da UFU. Ser�o pontuadas as atividades administrativas nomeadas pelo Reitor, com dura��o superior a tr�s meses.');
--142
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,10,51,'Membro de comiss�es de �tica, de infec��o hospitalar, de resid�ncia m�dica (COREME) e padroniza��o de medicamentos permanente da UFU. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses.');
--143
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,5,13,'Representante de Unidade Acad�mica ou de Unidade Especial de Ensino em Associa��o Docente (ADUFU). Ser�o pontuadas as atividades de representa��o com dura��o superior a tr�s meses e comprovadas por Portaria de nomea��o do Diretor da Unidade.');
--144
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,10,52,'Membro de comiss�es externas � Unidade, nomeadas pela Administra��o Superior da UFU ou por �rg�os da administra��o p�blica. Ser�o consideradas as comiss�es nomeadas por Portarias das Pr�-Reitorias, Reitoria e da administra��o p�blica.');
--145
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,10,52,'Membro de comit� assessor de ag�ncia de fomento. Ser�o pontuadas as participa��es comprovadas por documento de nomea��o ou declara��o da presid�ncia do comit�.');
--146
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,10,53,'Coordena��o de estruturas criadas na Unidade, de acordo com o Regimento Interno da mesma. Ser�o pontuadas as atividades com dura��o superior a tr�s meses e comprovadas por documento de homologa��o do cargo ou declara��o do Diretor da Unidade. Ser�o limitadas as participa��es em at� tr�s cargos por semestre.');
--147
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,5,54,'Membro de Conselhos na UFU. Ser�o pontuadas as atividades com dura��o superior a tr�s meses, comprovadas por documento de homologa��o do cargo ou por declara��o do Diretor. A participa��o como membro de Conselho com cargos de CD ou FG n�o deve ser pontuada neste item.');
--148
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,5,13,'Membro de Comiss�o Permanente da Unidade. Ser�o consideradas as comiss�es nomeadas pelo Diretor da Unidade e comprovadas por Portaria. Ser�o pontuadas as atividades com dura��o superior a tr�s meses, comprovadas por documento de nomea��o da comiss�o pelo Diretor da Unidade.');
--149
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,5,13,'Membro de Colegiado das Unidades Especiais de Ensino, de Curso de Gradua��o ou de Programa de P�s-gradua��o. Ser�o pontuadas as atividades administrativas com dura��o superior a tr�s meses, comprovadas por documento de homologa��o do cargo ou por declara��o do Diretor da Unidade.');
--150
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,10,55,'Presidente, em efetivo exerc�cio, de diretoria de associa��o cient�fica relacionada � sua �rea profissional. A pontua��o deve ser comprovada por documento de homologa��o do cargo.');
--151
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,5,32,'Membro, em efetivo exerc�cio, de diretoria de associa��o cient�fica relacionada � sua �rea profissional. A pontua��o deve ser comprovada por documento de homologa��o do cargo.');
--152
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (10,2,51,'Membro de comiss�es internas da Unidade Acad�mica. O docente poder� pontuar sua participa��o em at� quatro comiss�es por semestre, oficializadas por Ordem de Servi�o ou Portaria.');
--153
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_pontuacaoreferencia, tipo_multiplicador, tipo_descricao) VALUES (10,0,0.0055,56,'Substitui��es de docentes com cargo de dire��o, comprovadas por Portaria.');

-- ATIVIDADES DE ENSINO REMUNERADAS

--154
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (1,10,57,'Aula te�rica ou pr�tica de disciplinas ministradas em cursos de p�s-gradua��o lato sensu da UFU, com remunera��o complementar, aprovadas pelo Conselho da Unidade.');
--155
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (1,1,58,'Aula pr�tica de cursos de p�s-gradua��o lato sensu, com remunera��o suplementar, para turmas com mais de 8 alunos, equivalente � turma padr�o para este item.');

-- ATIVIDADES DE EXTENS�O E PRESTA��O DE SERVI�OS REMUNERADAS
--156
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (7,1,59,'Curso de extens�o ministrado com aprova��o do Conselho da Unidade e registrado na PROEX, com remunera��o complementar.');
--157
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (7,0.5,60,'Consultoria, assessoria, per�cia ou sindic�ncia realizadas e aprovadas pela Unidade, com remunera��o complementar.');
--158
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (7,15,13,'Coordena��o de Curso de P�s-gradua��o lato sensu, com remunera��o complementar. A atividade ser� pontuada se devidamente comprovada por declara��o do Diretor ou ata da reuni�o do Conselho da Unidade. Ser�o pontuadas as atividades com dura��o m�nima de tr�s meses.');
--159
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (7,30,13,'Coordena��o de projetos de extens�o com financiamento externo e com remunera��o complementar. Ser�o pontuadas as coordena��es com dura��o igual ou superior a seis meses, comprovadas por documento de aprova��o do projeto pelo �rg�o de fomento.');
--160
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (7,15,13,'Coordena��o de projetos de extens�o com financiamento interno e registrado na PROEX e com remunera��o complementar. Ser�o pontuadas as coordena��es com dura��o igual ou superior a tr�s meses.');
--161
INSERT INTO tipo (tipo_categoria, tipo_pontuacao, tipo_multiplicador, tipo_descricao) VALUES (7,5,13,'Membro de equipe de projetos de extens�o com financiamento externo ou interno e com remunera��o complementar. Ser�o pontuadas as participa��es comprovadas por declara��o do Coordenador do projeto ou Diretor da Unidade Acad�mica.');