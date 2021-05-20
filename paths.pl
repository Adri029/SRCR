
caminhoNome('R do Alecrim', 'R Ferragial').
caminhoNome('R do Alecrim', 'R Ataíde').
caminhoNome('R do Alecrim', 'Pc Duque da Terceira').
caminhoNome('R Corpo Santo', 'Lg Corpo Santo').
caminhoNome('R Corpo Santo', 'Tv Corpo Santo').
caminhoNome('Tv Corpo Santo', 'R Bernardino da Costa').
caminhoNome('Tv Corpo Santo', 'Cais do Sodré').
caminhoNome('R Bernardino da Costa', 'Lg Corpo Santo').
caminhoNome('R Bernardino da Costa', 'Pc Duque da Terceira').
caminhoNome('Lg Conde-Barão', 'R da Boavista').
caminhoNome('Lg Conde-Barão', 'Bqr do Duro').
caminhoNome('Lg Conde-Barão', 'R Mastros').
caminhoNome('Lg Conde-Barão', 'Tv do Cais do Tojo').
caminhoNome('Tv Marquês de Sampaio', 'R da Boavista').
caminhoNome('R da Boavista', 'R São Paulo').
caminhoNome('R da Boavista', 'Bqr dos Ferreiros').
caminhoNome('R da Boavista', 'Pto Galega').
caminhoNome('R da Boavista', 'R Instituto Industrial').
caminhoNome('Tv do Cais do Tojo', 'R Cais do Tojo').
caminhoNome('R Cais do Tojo', 'Av Dom Carlos I').
caminhoNome('R Cais do Tojo', 'Bqr do Duro').
caminhoNome('Bqr do Duro', 'R Dom Luís I').
caminhoNome('Tv Santa Catarina', 'R Santa Catarina').
caminhoNome('R Ferreiros a Santa Catarina', 'Bqr dos Ferreiros').
caminhoNome('R Ferreiros a Santa Catarina', 'R Santa Catarina').
caminhoNome('R Instituto Industrial', 'R Dom Luís I').
caminhoNome('R Instituto Industrial', 'Av 24 de Julho').
caminhoNome('R Moeda', 'R São Paulo').
caminhoNome('R Moeda', 'Pc Dom Luís I').
caminhoNome('Tv Carvalho', 'R Ribeira Nova').
caminhoNome('Tv Carvalho', 'Pc São Paulo').
caminhoNome('Tv Carvalho', 'R São Paulo').
caminhoNome('R Dom Luís I', 'Av Dom Carlos I').
caminhoNome('R Dom Luís I', 'Bqr dos Ferreiros').
caminhoNome('R Dom Luís I', 'Pc Dom Luís I').
caminhoNome('Pc Dom Luís I', 'Av 24 de Julho').
caminhoNome('Tv Condessa do Rio', 'Pc Dom Luís I').
caminhoNome('Pc Dom Luís I', 'R Ribeira Nova').
caminhoNome('R Ribeira Nova', 'R Remolares').
caminhoNome('R Ribeira Nova', 'R Instituto Dona Amélia').
caminhoNome('R Ribeira Nova', 'Pc Dom Luís I').
caminhoNome('R São Paulo', 'R Corpo Santo').
caminhoNome('R São Paulo', 'R Flores').
caminhoNome('R São Paulo', 'Pc São Paulo').
caminhoNome('R São Paulo', 'Tv dos Remolares').
caminhoNome('R São Paulo', 'Tv Corpo Santo').
caminhoNome('R São Paulo', 'Tv Carvalho').
caminhoNome('R São Paulo', 'Bc da Moeda').
caminhoNome('R São Paulo', 'Cc da Bica Grande').
caminhoNome('R São Paulo', 'R Moeda').
caminhoNome('R Nova do Carvalho', 'Pc São Paulo').
caminhoNome('R Nova do Carvalho', 'Tv dos Remolares').
caminhoNome('R Nova do Carvalho', 'Pc São Paulo').
caminhoNome('R Nova do Carvalho', 'R do Alecrim').
caminhoNome('R Nova do Carvalho', 'Tv Corpo Santo').
caminhoNome('R Remolares', 'Pc Duque da Terceira').
caminhoNome('R Remolares', 'Tv dos Remolares').
caminhoNome('R Remolares', 'Tv Ribeira Nova').
caminhoNome('Tv dos Remolares', 'Av 24 de Julho').
caminhoNome('Tv dos Remolares', 'R Nova do Carvalho').
caminhoNome('Tv dos Remolares', 'R São Paulo').
caminhoNome('Cais do Sodré', 'Pc Duque da Terceira').
caminhoNome('Cais do Sodré', 'Tv Corpo Santo').
caminhoNome('Cais do Sodré', 'Lg Corpo Santo').
caminhoNome('Bc da Boavista', 'R da Boavista').
caminhoNome('Tv Ribeira Nova', 'R Remolares').
caminhoNome('Tv Ribeira Nova', 'R Nova do Carvalho').
caminhoNome('Pc Ribeira Nova', 'Av 24 de Julho').
caminhoNome('Pc Ribeira Nova', 'R Ribeira Nova').
caminhoNome('Pc São Paulo', 'Tv Carvalho').
caminhoNome('Pc São Paulo', 'Tv Ribeira Nova').
caminhoNome('Pc Duque da Terceira', 'Cais do Sodré').
caminhoNome('Pc Duque da Terceira', 'R Bernardino da Costa').
caminhoNome('Pc Duque da Terceira', 'R Remolares').
caminhoNome('Pc Duque da Terceira', 'Av 24 de Julho').
caminhoNome('Lg Corpo Santo', 'Cais do Sodré').
caminhoNome('Lg Corpo Santo', 'R Arsenal').
caminhoNome('Lg Corpo Santo', 'Cc do Ferragial').
caminhoNome('Lg Corpo Santo', 'R Corpo Santo').
caminhoNome('Bc Francisco André', 'R da Boavista').
caminhoNome('Tv de São Paulo', 'Pc São Paulo').
caminhoNome('Tv de São Paulo', 'R Ribeira Nova').
caminhoNome('Av 24 de Julho', 'Pc Duque da Terceira').
caminhoNome('Av 24 de Julho', 'Tv dos Remolares').
caminhoNome('Av 24 de Julho', 'Pc Ribeira Nova').

caminho(-2,K) :- local(K,_,_,_,_,_).
caminho(-1,K) :- local(K,_,_,_,_,_).
caminho(X,Y) :- local(X,_,_,NomeX,_,_),
				local(Y,_,_,NomeY,_,_),
				caminhoNome(NomeX,NomeY).