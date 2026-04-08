librarian::shelf(microeco, reticulate, ggplot2, hrbrthemes, cols4all, dplyr, tidyplots, ggrepel, ggsci, magrittr)

rpsB_rarefied <- readRDS(file = "2026_BITE_FW_MCFA_paper/fig3/singlem_rpsB.rds.xz")

rpsB_rarefied$cal_betadiv(unifrac = F)

beta_diversity_index <- trans_beta$new(
    dataset = rpsB_rarefied,
    group = "default_group",
    measure = "bray"
)
beta_diversity_index$cal_ordination(method = "PCoA")
coords <- beta_diversity_index$res_ordination$scores
#
beta_diversity_index$res_ordination$eig
# PCo1  PCo2
# 29.3  19.6

beta_diversity_index$cal_anosim(group = "default_group")
beta_diversity_index$res_anosim
# Test permutations statistic.R p.value Significance
# 1 ANOSIM for all groups          999   0.9428804   0.001          ***

coords |>
    ggplot(aes(x = PCo1, y = PCo2, color = add_acid_type_group, shape = factor(day), alpha = add_acid_conc_cat)) +
    geom_point(size = 2) +
    scale_color_locuszoom() +
    scale_fill_locuszoom() +
    scale_x_continuous(limits = c(-0.6, 0.4)) +
    scale_y_continuous(limits = c(-0.4, 0.6)) +
    theme_bw() +
    theme(
        aspect.ratio = 1 / 1,
        axis.title.x = element_text(),
        axis.title.y = element_text(),
        axis.text.x = element_text(size = 9, color = "gray21"),
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
    xlab("PCoA 1 (29.3%)") +
    ylab("PCoA 2 (19.6%)")

ggsave("2026_BITE_FW_MCFA_paper/fig3/fig3a.pdf", width = 4, height = 4)
