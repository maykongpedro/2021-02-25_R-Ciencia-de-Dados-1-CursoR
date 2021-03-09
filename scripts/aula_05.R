
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

# inserindo a reta x = y
imdb %>%
  ggplot2::ggplot() +
  ggplot2::geom_point(aes(x = orcamento, y = receita)) +
  ggplot2::geom_abline(intercept = 0,
                       slope = 1,
                       color = "red")

# colocar a reta antes da camada dos pontos
imdb %>%
  ggplot2::ggplot() +
  ggplot2::geom_abline(intercept = 0,
                       slope = 1,
                       color = "red") +
  ggplot2::geom_point(aes(x = orcamento, y = receita))

# categorizando o lucro antes
imdb %>%
  dplyr::mutate(lucrou = dplyr::if_else(lucro <= 0,
                                       "Não",
                                       "Sim")) %>% 
  ggplot2::ggplot() +
  ggplot2::geom_point(aes(x = orcamento,
                          y = receita,
                          color = lucrou))


# salvando um gráfico em um arquivo
p <- 
  imdb %>%
  dplyr::filter(!is.na(lucro)) %>% 
  dplyr::mutate(lucrou = dplyr::if_else(lucro <= 0,
                                        "Não",
                                        "Sim")) %>% 
  ggplot2::ggplot() +
  ggplot2::geom_point(aes(x = orcamento,
                          y = receita,
                          color = lucrou))

p

# caso não seja gerado o objeto "p", ele salvará o último gráfico plotado

ggplot2::ggsave("./outputs/meu_grafico.png",
                plot = p)


ggplot2::ggsave("./outputs/meu_grafico_tamanho_definido.png",
                plot = p,
                width = 12,
                height = 10)


  


