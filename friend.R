# 导入字体
extrafont::font_import() # 这里需要输入y然后等待一段时间

# 导入包
library(tidyverse)
library(friends)
library(cowplot)

# 转化数据
plot_friends <- friends_info %>% 
  arrange(season,episode) %>% # 按照每一季每一集降序
  mutate(season = factor(season),
  rn = row_number()) %>%  # 生成序列
  group_by(season) %>% 
  mutate(avg_rating = mean(imdb_rating),
         start = min(rn),
         end = max(rn),
         median = median(rn)) %>% 
  ungroup() # 分组在展开


df_lines <- plot_friends %>% 
  group_by(season) %>% 
  summarise(start= mean(start),
            end = mean(end),
            s_avg = unique(avg_rating)) %>% 
  mutate(lag_rn = lead(start,default = max(end)),
         lag_rating = lead(s_avg,default = max(s_avg)))

# 画图主体部分

theme_set(hrbrthemes::theme_ipsum_rc(base_family = "Trattatello",
                                     subtitle_family = 'Trattatello',
                                     caption_family = 'Trattatello'))
# 设置背景
theme_update(panel.background = element_rect(fill = NA,color = NA),
             panel_border = element_rect(fill = NA,color = NA),
             panel.grid.major.y = element_blank(),
             panel.grid.major.x = element_blank(),
             panel.grid.minor = element_blank(),
             axis.text.x = element_blank(),
             axis.text.y = element_text(size = 13),
             axis.ticks = element_blank(),
             axis.title.y = element_text(size = 15,
                                         margin = margin(r = 10),
                                         hjust = 0.5,
                                         face = 'bold'),
             plot.margin = margin(10,25,10,25))

p <- plot_friends %>% 
  ggplot(aes(x=rn,
             y=imdb_rating))+
  geom_abline(data = tibble(y=7:10),
              aes(yintercept = y),
              color = '#D3D3D3')+
  geom_segment(aes(y=avg_rating,
                   yend = avg_rating, 
                   x = start,
                   xend = end,
                   color = season,
                   color = after_scale(colorspace::darken(color,0.1))),
               lwd=2.5
                   )+
  geom_segment(aes(y=imdb_rating,
                   yend = avg_rating,
                   x = rn,
                   xend = rn,
                   color = season,
                   color = after_scale(colorspace::darken(color,0.3))))+
  geom_segment(data = df_lines, 
               aes(x = end, 
                   xend = lag_rn,
                   y = s_avg,
                   yend = lag_rating,
                   color = season,
                   color = after_scale(colorspace::darken(color, .3))),
               lwd = .7)
  