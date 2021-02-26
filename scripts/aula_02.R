
# CTRL + SHIFT + R = Criar divisórias

# Importação --------------------------------------------------------------

# Carregar pacotes
library(readr)

# Carregando um ano
imbd <- readr::read_rds("dados/por_ano/imdb_2016.rds")

# Listando arquivos na pasta
arquivos <-
  list.files("dados/por_ano/",
             full.names = TRUE,
             pattern = ".rds$")

# Testando purr
#purrr::map(1:10, sqrt)

# Abrindo todos os arquivos e unindo eles
imdb <- purrr::map_dfr(arquivos,
               read_rds)

# -------------------------------------------------------------------------

# Carregando nome das colunas que consta em uma planilha separada
nome_colunas <-
  readxl::read_excel(
    "dados/imdb_nao_estruturada.xlsx",
    sheet = 2
  )

# Carregando base oficial pulando as 4 primeiras linhas
imdb <-
  readxl::read_excel(
    "dados/imdb_nao_estruturada.xlsx",
    skip = 4,
    col_names = FALSE,
    n_max = 3713
  )







