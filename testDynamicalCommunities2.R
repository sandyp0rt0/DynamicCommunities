

test_that("Grafo vazio para fun��o born",{
  g = make_empty_graph(0,F)
  V(g)$p = 0
  g = born(g)
  cat("\n")
  nc = length(unique(V(g)$p[V(g)$p!=0]))
  expect_that(nc, equals(1))
  expect_that(mean(degree(g)), equals(avgdegree, tolerance=1))
  expect_that(max(degree(g)),is_less_than(maxdegree+1))
  mixingReal = calculaMixing(g)
  expect_that(mixingReal, equals(mixing, tolerance = toleranciamixing, scale=1))
  expect_that(menorComunidade(g), is_more_than(minsize-1))
  expect_that(maiorComunidade(g), is_less_than(maxsize+1))
})

test_that("Grafo vazio para fun��o extinction",{
  g = make_empty_graph(0,F)
  g = extinction(g)
  cat("\n")
  nv = vcount(g)
  expect_that(nv, equals(0))
})

test_that("Grafo vazio para fun��o growth",{
  g = make_empty_graph(0,F)
  V(g)$p = 0
  g = growth(g)
  cat("\n")
  nv = vcount(g)
  expect_equal(nv,0)
  nc = length(unique(V(g)$p[V(g)$p!=0]))
  expect_that(nc, equals(0))
  
})

test_that("Grafo vazio para fun��o growth",{
  g = make_empty_graph(0,F)
  V(g)$p = 0
  g = contraction(g)
  nv = vcount(g)
  expect_equal(nv,0)
  nc = length(unique(V(g)$p[V(g)$p!=0]))
  expect_that(nc, equals(0))
  
})




nv = sample(minsize:(round(maxsize/3)),1)
g = make_full_graph(nv)
V(g)$p=1
while(mean(degree(g))>avgdegree){
  v1 = sample(1:nv,1)
  while(degree(g,v1)<2){
    v1 = sample(1:nv,1)
  }
  v2 = sample(as.vector(neighbors(g,v1)),1)
  while(degree(g,v2)<2){
    v2 = sample(as.vector(neighbors(g,v1)),1)
  }
  aresta = get.edge.ids(g,c(v1,v2))
  g = delete.edges(g,aresta)
}



test_that("Grafo com 1 comunidade para fun��o born",{
  g = born(g)
  cat("\n")
  nc = length(unique(V(g)$p[V(g)$p!=0]))
  expect_that(nc, equals(2))
  expect_that(mean(degree(g)), equals(avgdegree, tolerance=1))
  expect_that(max(degree(g)),is_less_than(maxdegree+1))
  mixingReal = calculaMixing(g)
  expect_that(mixingReal, equals(mixing, tolerance = toleranciamixing, scale=1))
  expect_that(menorComunidade(g), is_more_than(minsize-1))
  expect_that(maiorComunidade(g), is_less_than(maxsize+1))
})

test_that("Grafo com 1 comunidade para fun��o extinction",{
  g = extinction(g)
  cat("\n")
  nv = vcount(g)
  expect_that(nv, equals(0))
})

test_that("Grafo com 1 comunidade para fun��o growth",{
  g = growth(g)
  cat("\n")
  expect_gte(vcount(g),nv)
  tamcomu = length(V(g)$p[V(g)$p==1])
  expect_gte(tamcomu,nv)
  nc = length(unique(V(g)$p[V(g)$p!=0]))
  expect_that(nc, equals(1))
  expect_that(mean(degree(g)), equals(avgdegree, tolerance=1))
  expect_that(max(degree(g)),is_less_than(maxdegree+1))
  mixingReal = calculaMixing(g)
  expect_that(mixingReal, equals(mixing, tolerance = toleranciamixing, scale=1))
  expect_that(menorComunidade(g), is_more_than(minsize-1))
  expect_that(maiorComunidade(g), is_less_than(maxsize+1))
})

test_that("Grafo com 1 comunidade para fun��o contraction",{
  g = contraction(g)
  cat("\n")
  expect_lte(vcount(g),nv)
  tamcomu = length(V(g)$p[V(g)$p==idcomu])
  expect_lte(tamcomu,nv)
  nc = length(unique(V(g)$p[V(g)$p!=0]))
  expect_that(nc, equals(1))
  expect_that(mean(degree(g)), equals(avgdegree, tolerance=1))
  expect_that(max(degree(g)),is_less_than(maxdegree+1))
  mixingReal = calculaMixing(g)
  expect_that(mixingReal, equals(mixing, tolerance = toleranciamixing, scale=1))
  expect_that(menorComunidade(g), is_more_than(minsize-1))
  expect_that(maiorComunidade(g), is_less_than(maxsize+1))
})


grafoInicial = criarGrafoInicial(path)
#ilustrarGrafo(grafoInicial)

cat("\n")
test_that("Fun��o criarGrafoInicial",{
  
  
  expect_that(is.igraph(grafoInicial), is_true())
  
  expect_that(vcount(grafoInicial),equals(nvertices))
  expect_that(mean(degree(grafoInicial)), equals(avgdegree, tolerance=1))
  expect_that(max(degree(grafoInicial)),is_less_than(maxdegree+1))
  mixingReal = calculaMixing(grafoInicial)
  expect_that(mixingReal, equals(mixing, tolerance = toleranciamixing, scale=1))
  expect_that(menorComunidade(grafoInicial), is_more_than(minsize-1))
  expect_that(maiorComunidade(grafoInicial), is_less_than(maxsize+1))
  
})

g = born(grafoInicial)
cat("\n")
test_that("Fun��o born",{
  #grafoInicial = criarGrafoInicial()
  
  
  
  idcomu = max(V(g)$p)
  tamcomu = length(V(g)$p[V(g)$p==idcomu])
  
  expect_that(vcount(g),equals(nvertices+tamcomu))
  expect_that(mean(degree(g)), equals(avgdegree, tolerance=1))
  expect_that(max(degree(g)),is_less_than(maxdegree+1))
  mixingReal = calculaMixing(g)
  expect_that(mixingReal, equals(mixing, tolerance = toleranciamixing, scale=1))
  expect_that(menorComunidade(g), is_more_than(minsize-1))
  expect_that(maiorComunidade(g), is_less_than(maxsize+1))
  
  
})

g = born(g)
g = born(g)
cat("\n")
test_that("Usando a fun��o born 3 vezes",{
  idcomu = max(V(g)$p)
  tamcomu = length(V(g)$p[V(g)$p==idcomu])
  
  expect_that(mean(degree(g)), equals(avgdegree, tolerance=1))
  expect_that(max(degree(g)),is_less_than(maxdegree+1))
  mixingReal = calculaMixing(g)
  expect_that(mixingReal, equals(mixing, tolerance = toleranciamixing, scale=1))
  expect_that(menorComunidade(g), is_more_than(minsize-1))
  expect_that(maiorComunidade(g), is_less_than(maxsize+1))
})

g = born(g)
g = born(g)

cat("\n")
test_that("Usando a fun��o born 5 vezes",{
  idcomu = max(V(g)$p)
  tamcomu = length(V(g)$p[V(g)$p==idcomu])
  
  expect_that(mean(degree(g)), equals(avgdegree, tolerance=1))
  expect_that(max(degree(g)),is_less_than(maxdegree+1))
  mixingReal = calculaMixing(g)
  expect_that(mixingReal, equals(mixing, tolerance = toleranciamixing, scale=1))
  expect_that(menorComunidade(g), is_more_than(minsize-1))
  expect_that(maiorComunidade(g), is_less_than(maxsize+1))
})

idcomu = sample(V(g)$p,1)
tamcomu = length(V(g)$p[V(g)$p==idcomu])
nvertices = vcount(g)
g = extinction(g, comu = idcomu)
cat("\n")
test_that("Fun��o extinction",{
  
  expect_that(vcount(g),equals(nvertices-tamcomu))
  nv = length(V(g)$p[V(g)$p==idcomu])
  expect_that(nv,equals(0))
  expect_that(mean(degree(g)), equals(avgdegree, tolerance=1))
  expect_that(max(degree(g)),is_less_than(maxdegree+1))
  mixingReal = calculaMixing(g)
  expect_that(mixingReal, equals(mixing, tolerance = toleranciamixing, scale=1))
  expect_that(menorComunidade(g), is_more_than(minsize-1))
  expect_that(maiorComunidade(g), is_less_than(maxsize+1))
  
})


idcomu = sample(V(g)$p,1)
tamcomu = length(V(g)$p[V(g)$p==idcomu])
nvertices = vcount(g)
g = growth(g,comu=idcomu)
cat("\n")
test_that("Fun��o growth",{
  
  expect_gte(vcount(g),nvertices)
  nv = length(V(g)$p[V(g)$p==idcomu])
  expect_gte(nv,tamcomu)
  expect_that(mean(degree(g)), equals(avgdegree, tolerance=1))
  expect_that(max(degree(g)),is_less_than(maxdegree+1))
  mixingReal = calculaMixing(g)
  expect_that(mixingReal, equals(mixing, tolerance = toleranciamixing, scale=1))
  expect_that(menorComunidade(g), is_more_than(minsize-1))
  expect_that(maiorComunidade(g), is_less_than(maxsize+1))
})


idcomu = sample(V(g)$p,1)
tamcomu = length(V(g)$p[V(g)$p==idcomu])
nvertices = vcount(g)
g = contraction(g,comu=idcomu)
cat("\n")
test_that("Fun��o contraction",{
  
  expect_lte(vcount(g),nvertices)
  nv = length(V(g)$p[V(g)$p==idcomu])
  expect_lte(nv,tamcomu)
  expect_that(mean(degree(g)), equals(avgdegree, tolerance=1))
  expect_that(max(degree(g)),is_less_than(maxdegree+1))
  mixingReal = calculaMixing(g)
  expect_that(mixingReal, equals(mixing, tolerance = toleranciamixing, scale=1))
  expect_that(menorComunidade(g), is_more_than(minsize-1))
  expect_that(maiorComunidade(g), is_less_than(maxsize+1))
})
#ilustrarGrafo(g)



