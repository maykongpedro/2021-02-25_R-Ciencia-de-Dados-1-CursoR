
# Pacotes -----------------------------------------------------------------
library(tidyverse)



# Base de dados -----------------------------------------------------------

imdb <- read_rds("dados/imdb.rds")


# criando coluna de lucro
imdb <-
  imdb %>%
  dplyr::mutate(lucro = receita - orcamento)


# Gráfico de pontos (dispersão) -------------------------------------------

# apenas o canvas
imdb %>% 
  ggplot2::ggplot()


# salvando em um objeto
p <- imdb %>%
  ggplot2::ggplot()


# gráfico de dispersão de receita contra o orçamento
imdb %>%
  ggplot2::ggplot() +
  ggplot2::geom_point(aes(x = orcamento, y = receita))




