# Objetivo: investigar a densidade (relação peso/altura) dos personagens

library(dplyr)

view(starwars)

# média do peso
starwars %>% 
  dplyr::summarise(peso_medio = mean(mass, na.rm = TRUE))

# média do peso por sexo
starwars %>% 
  dplyr::group_by(sex) %>% 
  dplyr::summarise(peso_medio = mean(mass, na.rm = TRUE))

# média do peso por sexo e espécie
starwars %>% 
  dplyr::filter(!is.na(mass)) %>% 
  dplyr::group_by(species, sex) %>% 
  dplyr::summarise(peso_medio = mean(mass, na.rm = TRUE))

# média do peso agrupado por espécie - top 10 em ordem descrecente
starwars %>% 
  dplyr::filter(!is.na(mass)) %>% 
  dplyr::group_by(species) %>% 
  dplyr::summarise(peso_medio = mean(mass, na.rm = TRUE)) %>% 
  dplyr::top_n(10, peso_medio) %>% 
  dplyr::arrange(desc(peso_medio))

# média do peso e da altura agrupado por espécie - top 10 em ordem descrescente
starwars %>% 
  dplyr::filter(!is.na(mass)) %>% 
  dplyr::group_by(species) %>% 
  dplyr::summarise(peso_medio = mean(mass, na.rm = TRUE),
                   altura_media = mean(height, na.rm = TRUE)/ 100) %>% 
  dplyr::top_n(10, peso_medio) %>% 
  dplyr::arrange(desc(peso_medio))

# média do peso, altura e imc agrupado por espécie - top 10 em ordem descrescente
starwars %>% 
  dplyr::filter(!is.na(mass)) %>% 
  dplyr::group_by(species) %>% 
  dplyr::mutate(imc = mass/(height / 100)^2) %>% 
  dplyr::summarise(peso_medio = mean(mass, na.rm = TRUE),
                   altura_media = mean(height, na.rm = TRUE)/ 100,
                   imc_medio = mean(imc, na.rm = TRUE)) %>% 
  dplyr::top_n(10, peso_medio) %>% 
  dplyr::arrange(desc(peso_medio))

# plot do gráfico de dispersão da altura pelo peso
starwars %>% 
  dplyr::filter(mass < 500) %>% 
  ggplot2::ggplot() +
  ggplot2::geom_point(ggplot2::aes(x = height, y = mass))
  