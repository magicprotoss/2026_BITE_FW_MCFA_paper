librarian::shelf(microeco, reticulate, ggplot2, hrbrthemes, cols4all, dplyr, tidyplots, ggrepel, ggsci, magrittr, readxl, tidyverse)

t1 <- readRDS("2026_BITE_FW_MCFA_paper/fig3/ko_env.rds.xz")

t1$cal_ordination(method = "dbRDA", use_measure = "bray", taxa_level = "OTU")
t1$trans_ordination(adjust_arrow_length = TRUE, max_perc_env = 1.5)
t1[["res_ordination_trans"]][["eigval"]]
# dbRDA1           dbRDA2           dbRDA3           dbRDA4           dbRDA5           dbRDA6           dbRDA7
# "dbRDA1 [70.3%]" "dbRDA2 [14.5%]"            "6.9"            "4.5"            "1.9"            "1.3"            "0.6"

points_df <- t1[["res_ordination_trans"]][["df_sites"]]
arrows_df <- t1[["res_ordination_trans"]]$df_arrows

points_df |>
    ggplot(aes(x = x, y = y, color = add_acid_type_group, shape = factor(day), alpha = add_acid_conc_cat)) +
    geom_point(size = 2) +
    geom_hline(yintercept = 0, linetype = "dashed", color = "gray35") +
    geom_vline(xintercept = 0, linetype = "dashed", color = "gray35") +
    geom_segment(
        data = arrows_df,
        inherit.aes = F,
        aes(x = 0, y = 0, xend = x, yend = y),
        arrow = arrow(length = unit(0.15, "cm")),
        color = "gray21",
        size = 0.35
    ) +
    geom_text_repel(
        data = arrows_df |>
            rownames_to_column(var = "env"),
        inherit.aes = F,
        aes(x = x, y = y, label = env),
        color = "gray21",
        size = 2,
    ) +
    scale_color_locuszoom() +
    scale_fill_locuszoom() +
    scale_shape_manual(values = c(17, 15, 3)) +
    scale_x_continuous(limits = c(-1.5, 1.1)) +
    scale_y_continuous(limits = c(-1, 1.1)) +
    theme_bw() +
    theme(
        aspect.ratio = 1 / 1,
        axis.title.x = element_text(),
        axis.title.y = element_text(),
        axis.text.x = element_text(size = 9, color = "gray21", angle = 45, hjust = 1),
        panel.grid.major = element_line(size = 0.35),
        panel.grid.minor = element_blank(),
        panel.border = element_rect(
            color = "black", # Set the color of the border
            fill = NA, # Ensure the background remains transparent (NA)
            size = 0.75 # Set the line thickness (size) in points
        )
        # plot.title = element_text(color = "gray21", size = 9, vjust = -1),
        # text = element_text(family = "Arial")
    ) +
    xlab("dbRDA 1 (70.3%)") +
    ylab("dbRDA 2 (14.5%)")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig3/fig3h.pdf",
    width = 4,
    height = 4
)
