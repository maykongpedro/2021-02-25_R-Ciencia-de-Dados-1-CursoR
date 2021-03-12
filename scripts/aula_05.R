
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



# Gráfico de linhas -------------------------------------------------------

# nota média dos filmes ao longo dos anos
imdb %>% 
  dplyr::group_by(ano) %>% 
  dplyr::summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot2::ggplot()+
  ggplot2::geom_line(aes(x = ano, y = nota_media))


# número de filmes coloridos e preto e branco por ano
imdb %>% 
  dplyr::filter(!is.na(cor)) %>% 
  dplyr::group_by(ano, cor) %>% 
  dplyr::summarise(num_filmes = n()) %>% 
  ggplot2::ggplot() +
  ggplot2::geom_line(aes(x = ano, y = num_filmes, color = cor ))


# colocando pontos no gráfico
imdb %>% 
  dplyr::filter(ator_1 == "Robert De Niro") %>% 
  dplyr::group_by(ano) %>% 
  dplyr::summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot2::ggplot() +
  ggplot2::geom_line(aes(x = ano, y = nota_media))+
  ggplot2::geom_point(aes(x = ano, y = nota_media))


# reescrevendo de uma forma mais agradável
imdb %>% 
  dplyr::filter(ator_1 == "Robert De Niro") %>% 
  dplyr::group_by(ano) %>% 
  dplyr::summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot2::ggplot(aes(x = ano, y = nota_media))+
  ggplot2::geom_line(color = "#ff00ff", linetype = 4) +
  ggplot2::geom_point(color =  "purple", shape = 4)


# colocando as notas no gráfico
imdb %>% 
  dplyr::filter(ator_1 == "Robert De Niro") %>% 
  dplyr::group_by(ano) %>% 
  dplyr::summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  dplyr::mutate(nota_media = round(nota_media, 1)) %>% 
  ggplot2::ggplot(aes(x = ano, y = nota_media))+
  ggplot2::geom_line() +
  ggplot2::geom_label(aes(label = nota_media))



# Gráfico de barras -------------------------------------------------------

imdb %>% 
  dplyr::filter(!is.na(diretor)) %>% 
  dplyr::count(diretor) %>% 
  dplyr::top_n(10, n) %>% 
  ggplot2::ggplot() +
  ggplot2::geom_col(aes(y = diretor, x = n))

  
# tirando NA e pintando as barras
imdb %>%
  dplyr::count(diretor) %>%
  dplyr::filter(!is.na(diretor)) %>%
  dplyr::top_n(10, n) %>%
  ggplot2::ggplot() +
  ggplot2::geom_col(aes(y = diretor,
                        x = n,
                        fill = diretor),
                    color = "black",
                    show.legend = FALSE)


# invertendo as coordenadas
imdb %>%
  dplyr::count(diretor) %>%
  dplyr::filter(!is.na(diretor)) %>%
  dplyr::top_n(10, n) %>%
  ggplot2::ggplot() +
  ggplot2::geom_col(aes(x  = diretor,
                        y= n,
                        fill = diretor),
                    color = "black",
                    show.legend = FALSE)


# ordenando barras
imdb %>%
  dplyr::count(diretor) %>%
  dplyr::filter(!is.na(diretor)) %>%
  dplyr::top_n(10, n) %>%
  dplyr::mutate(
    diretor = forcats::fct_reorder(diretor, n)
  ) %>% 
  ggplot2::ggplot() +
  ggplot2::geom_col(
    aes(x = n, y = diretor, fill = diretor),
    show.legend =  FALSE
  )


# colocando label nas barras
imdb %>%
  dplyr::count(diretor) %>%
  dplyr::filter(!is.na(diretor)) %>%
  dplyr::top_n(10, n) %>%
  dplyr::mutate(
    diretor = forcats::fct_reorder(diretor, n)
  ) %>% 
  ggplot2::ggplot() +
  ggplot2::geom_col(
    aes(x = n, y = diretor, fill = diretor),
    show.legend =  FALSE
  ) +
  ggplot2::geom_label(aes(x = n/2,  y = diretor, label = n))



# Histogramas e boxplots --------------------------------------------------

# histograma do lucro dos filmes do Steven Spielberg
imdb %>% 
  dplyr::filter(diretor == "Steven Spielberg") %>% 
  ggplot2::ggplot()+
  ggplot2::geom_histogram(aes(x= lucro))


# arrumando o tamanho das bases
imdb %>% 
  dplyr::filter(diretor == "Steven Spielberg") %>% 
  ggplot2::ggplot()+
  ggplot2::geom_histogram(
    aes(x = lucro),
    binwidth = 100000000,
    color = "white"
  )

  
# boxplot do lucro dos filmes dos diretores que fizeram mais de 15 filmes
imdb %>% 
  dplyr::filter(!is.na(diretor)) %>% 
  dplyr::group_by(diretor) %>% 
  dplyr::filter(n() >= 15) %>% 
  ggplot2::ggplot() +
  ggplot2::geom_boxplot(aes(x = diretor, y = lucro))


# ordenando pela mediana=
imdb %>% 
  dplyr::filter(!is.na(diretor)) %>% 
  dplyr::group_by(diretor) %>% 
  dplyr::filter(n() >= 15) %>% 
  dplyr::ungroup() %>% 
  dplyr::mutate(
    diretor = forcats::fct_reorder(diretor, lucro, na.rm = TRUE)
  ) %>% 
  ggplot2::ggplot() +
  ggplot2::geom_boxplot(aes(x = diretor, y = lucro)) +
  ggplot2::geom_jitter(aes(x = diretor, y = lucro), alpha = 0.5)



# Título e labels ---------------------------------------------------------

# labels
imdb %>%
  ggplot2::ggplot()


# esca;as
imdb %>% 
  dplyr::group_by(ano) %>% 
  dplyr::summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot2::ggplot() +
  ggplot2::geom_line(aes(x = ano, y = nota_media)) +
  ggplot2::scale_x_continuous(breaks = seq(1916, 2016, 10)) +
  ggplot2::scale_y_continuous(breaks = seq(0, 10, 2))


# visão do gráfico
imdb %>% 
  dplyr::group_by(ano) %>% 
  dplyr::summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot2::ggplot() +
  ggplot2::geom_line(aes(x = ano, y = nota_media)) +
  ggplot2::scale_x_continuous(breaks = seq(1916, 2016, 10)) +
  ggplot2::scale_y_continuous(breaks = seq(0, 10, 2))+
  ggplot2::coord_cartesian(ylim = c(0, 10))


# Cores -------------------------------------------------------------------

# escolhendo cores pelo nome


# escolhendo hexadecimal


# mudando textos na legenda




# Temas -------------------------------------------------------------------

# temas prontos
imdb %>% 
  ggplot2::ggplot() +
  ggplot2::geom_point(aes (x = orcamento, y = receita)) +
  #ggplot2::theme_bw()
  ggplot2::theme_minimal()



# a função theme()
imdb %>% 
  ggplot2::ggplot() +
  ggplot2::geom_point( aes(x = orcamento, y = receita))+
  ggplot2::labs(
    title = "Gráfico de dispersão",
    subtitle = "Receita vs Orçamento"
  ) +
  ggplot2::theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )





  

