# Pacotes
library(rpart)
library(rpart.plot)
library(caret)

# Dados
data(iris)

# Separação treino/teste
set.seed(123)
indice_treino <- createDataPartition(
  y = iris$Sepal.Length,
  p = 0.7,
  list = FALSE
)

treino <- iris[indice_treino, ]
teste  <- iris[-indice_treino, ]

# Treinamento
modelo_tree <- rpart(
  Sepal.Length ~ ., 
  data = treino,
  method = "anova"
)

# Visualização
rpart.plot(modelo_tree)

# Previsão
pred_tree <- predict(
  modelo_tree,
  teste
)

# Avaliação
metricas <- postResample(
  pred = pred_tree,
  obs = teste$Sepal.Length
)

print(metricas)