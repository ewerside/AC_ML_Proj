# Pacotes
library(rpart)
library(rpart.plot)
library(caret)

# Dados
data(dados_jurimetria)

# CORREÇÃO: Converter a variável alvo para fator antes de qualquer etapa
dados_jurimetria$resultado <- as.factor(dados_jurimetria$resultado)

# Separação treino/teste
set.seed(123)
indice_treino <- createDataPartition(
  y = dados_jurimetria$resultado,
  p = 0.7,
  list = FALSE
)

treino <- dados_jurimetria[indice_treino, ]
teste  <- dados_jurimetria[-indice_treino, ]

# Treinamento
modelo_tree <- rpart(
  resultado ~ .,
  data = treino,
  method = "class"
)

# Visualização
rpart.plot(modelo_tree)

# Previsão
pred_tree <- predict(
  modelo_tree,
  teste,
  type = "class" # Retorna um fator com os níveis do treino
)

# Avaliação
confusionMatrix(
  data = pred_tree,
  reference = teste$resultado # Agora ambos são fatores com os mesmos níveis
)
