# Objetivo: descobrir qual o filme mais caro,
# mais lucrativo e com melhor nota dos anos 2000

# carregar pacotes necessários
if(!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, readr)


# carregar base
imdb <- readr::read_rds("dados/imdb.rds")


# Qual o filme mais caro? -------------------------------------------------

# opção 1
imdb %>% 
  dplyr::filter(ano %in% 2000:2009) %>% 
  dplyr::arrange(orcamento) %>% 
  dplyr::slice(1) %>% 
  View()

# opção 2
imdb %>%
  dplyr::filter(ano %in% 2000:2009) %>% 
  dplyr::filter(orcamento == max(orcamento,
                                 na.rm = TRUE))



# Qual o filme com melhor nota? -------------------------------------------

# opção 2
imdb %>%
  dplyr::filter(ano %in% 2000:2009) %>% 
  dplyr::filter(nota_imdb == max(nota_imdb,
                                 na.rm = TRUE))

# Qual o filme mais lucrativo? --------------------------------------------

# opção 2
imdb %>%
  dplyr::mutate(lucro = receita - orcamento ) %>% 
  dplyr::filter(ano %in% 2000:2009) %>% 
  dplyr::filter(lucro == max(lucro,
                                 na.rm = TRUE)) %>% 
  View()
