librarian::shelf(microeco, reticulate, ggplot2, cols4all, dplyr, tidyplots, ggrepel, ggsci, magrittr)

l6_otutab_long <- readRDS(file = "2026_BITE_FW_MCFA_paper/fig2/l6_data.rds.xz")

mycol <- c4a("tol.rainbow", 20)
mycol <- c("gray75", mycol)

# Ploting Data

# Butyric_Acid_CK

plot_df_1 <- l6_otutab_long |>
    filter(Butyric_Acid_CK == 1)

plot_df_1$new_sample_nane <- factor(
    plot_df_1$new_sample_nane,
    levels = unique(plot_df_1$new_sample_nane[order(plot_df_1$day_factor)])
)

plot_df_1 |>
    ggplot(aes(
        x = new_sample_nane, y = Relative_Abundance, fill = Taxon,
        stratum = Taxon, alluvium = Taxon
    )) +
    theme_bw() +
    geom_col(
        width = 1,
        color = NA, size = 0.5, show.legend = F
    ) + # 去掉柱子的描边
    geom_vline(xintercept = c(2.5, 4.5, 6.5), color = "gray21", size = 0.35, linetype = "dashed") +
    scale_fill_manual(values = mycol) +
    scale_y_continuous(expand = c(0, 0), limits = c(-0.1, 100.1), breaks = seq(0, 100, by = 20)) +
    scale_x_discrete(expand = c(0, 0)) +
    theme(
        legend.text = element_text(), legend.position = "right",
        legend.title = element_blank(),
        axis.text.x = element_text(size = 6)
    ) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + # Remove Grid
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    theme(aspect.ratio = 3 / 1) +
    xlab("Sample") +
    ylab("Relative Abundace (%)")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig2/comm_composition_genus_butyric_acid_ck.pdf",
    plot = last_plot(),
    width = 4,
    height = 4
)

# Butyric_Acid_B1

plot_df_2 <- l6_otutab_long |>
    filter(B1 == 1)

plot_df_2$new_sample_nane <- factor(
    plot_df_2$new_sample_nane,
    levels = unique(plot_df_2$new_sample_nane[order(plot_df_2$day_factor)])
)

plot_df_2 |>
    ggplot(aes(
        x = new_sample_nane, y = Relative_Abundance, fill = Taxon,
        stratum = Taxon, alluvium = Taxon
    )) +
    theme_bw() +
    geom_col(
        width = 1,
        color = NA, size = 0.5, show.legend = F
    ) + # 去掉柱子的描边
    geom_vline(xintercept = c(2.5, 4.5, 6.5), color = "gray21", size = 0.35, linetype = "dashed") +
    scale_fill_manual(values = mycol) +
    scale_y_continuous(expand = c(0, 0), limits = c(-0.1, 100.1), breaks = seq(0, 100, by = 20)) +
    scale_x_discrete(expand = c(0, 0)) +
    theme(
        legend.text = element_text(), legend.position = "right",
        legend.title = element_blank(),
        axis.text.x = element_text(size = 6),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank()
    ) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + # Remove Grid
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    theme(aspect.ratio = 3 / 1) +
    xlab("Sample")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig2/comm_composition_genus_butyric_acid_b1.pdf",
    plot = last_plot(),
    width = 4,
    height = 4
)

# Butyric_Acid_B2

plot_df_3 <- l6_otutab_long |>
    filter(B2 == 1)

plot_df_3$new_sample_nane <- factor(
    plot_df_3$new_sample_nane,
    levels = unique(plot_df_3$new_sample_nane[order(plot_df_3$day_factor)])
)

plot_df_3 |>
    ggplot(aes(
        x = new_sample_nane, y = Relative_Abundance, fill = Taxon,
        stratum = Taxon, alluvium = Taxon
    )) +
    theme_bw() +
    geom_col(
        width = 1,
        color = NA, size = 0.5, show.legend = F
    ) + # 去掉柱子的描边
    geom_vline(xintercept = c(2.5, 4.5, 6.5), color = "gray21", size = 0.35, linetype = "dashed") +
    scale_fill_manual(values = mycol) +
    scale_y_continuous(expand = c(0, 0), limits = c(-0.1, 100.1), breaks = seq(0, 100, by = 20)) +
    scale_x_discrete(expand = c(0, 0)) +
    theme(
        legend.text = element_text(), legend.position = "right",
        legend.title = element_blank(),
        axis.text.x = element_text(size = 6),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank()
    ) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + # Remove Grid
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    theme(aspect.ratio = 3 / 1) +
    xlab("Sample")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig2/comm_composition_genus_butyric_acid_b2.pdf",
    plot = last_plot(),
    width = 4,
    height = 4
)

# Butyric_Acid_B3

plot_df_4 <- l6_otutab_long |>
    filter(B3 == 1)

plot_df_4$new_sample_nane <- factor(
    plot_df_4$new_sample_nane,
    levels = unique(plot_df_4$new_sample_nane[order(plot_df_4$day_factor)])
)

plot_df_4 |>
    ggplot(aes(
        x = new_sample_nane, y = Relative_Abundance, fill = Taxon,
        stratum = Taxon, alluvium = Taxon
    )) +
    theme_bw() +
    geom_col(
        width = 1,
        color = NA, size = 0.5, show.legend = F
    ) + # 去掉柱子的描边
    geom_vline(xintercept = c(2.5, 4.5, 6.5), color = "gray21", size = 0.35, linetype = "dashed") +
    scale_fill_manual(values = mycol) +
    scale_y_continuous(expand = c(0, 0), limits = c(-0.1, 100.1), breaks = seq(0, 100, by = 20)) +
    scale_x_discrete(expand = c(0, 0)) +
    theme(
        legend.text = element_text(), legend.position = "right",
        legend.title = element_blank(),
        axis.text.x = element_text(size = 6),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank()
    ) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + # Remove Grid
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    theme(aspect.ratio = 3 / 1) +
    xlab("Sample")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig2/comm_composition_genus_butyric_acid_b3.pdf",
    plot = last_plot(),
    width = 4,
    height = 4
)

# Caproic_Acid_CK

plot_df_5 <- l6_otutab_long |>
    filter(Caproic_Acid_CK == 1)

plot_df_5$new_sample_nane <- factor(
    plot_df_5$new_sample_nane,
    levels = unique(plot_df_5$new_sample_nane[order(plot_df_5$day_factor)])
)

plot_df_5 |>
    ggplot(aes(
        x = new_sample_nane, y = Relative_Abundance, fill = Taxon,
        stratum = Taxon, alluvium = Taxon
    )) +
    theme_bw() +
    geom_col(
        width = 1,
        color = NA, size = 0.5
    ) + # 去掉柱子的描边
    geom_vline(xintercept = c(2.5, 4.5, 6.5), color = "gray21", size = 0.35, linetype = "dashed") +
    scale_fill_manual(values = mycol) +
    scale_y_continuous(expand = c(0, 0), limits = c(-0.1, 100.1), breaks = seq(0, 100, by = 10)) +
    scale_x_discrete(expand = c(0, 0)) +
    theme(
        legend.text = element_text(), legend.position = "right",
        legend.title = element_blank()
    ) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + # Remove Grid
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    theme(aspect.ratio = 4 / 3) +
    xlab("Sample") +
    ylab("Relative Abundace (%)")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig2/comm_composition_genus_Caproic_Acid_CK.pdf",
    plot = last_plot(),
    width = 6,
    height = 4
)

# Caproic_Acid_C1

plot_df_6 <- l6_otutab_long |>
    filter(C1 == 1)

plot_df_6$new_sample_nane <- factor(
    plot_df_6$new_sample_nane,
    levels = unique(plot_df_6$new_sample_nane[order(plot_df_6$day_factor)])
)

plot_df_6 |>
    ggplot(aes(
        x = new_sample_nane, y = Relative_Abundance, fill = Taxon,
        stratum = Taxon, alluvium = Taxon
    )) +
    theme_bw() +
    geom_col(
        width = 1,
        color = NA, size = 0.5, show.legend = F
    ) + # 去掉柱子的描边
    geom_vline(xintercept = c(2.5, 4.5, 6.5), color = "gray21", size = 0.35, linetype = "dashed") +
    scale_fill_manual(values = mycol) +
    scale_y_continuous(expand = c(0, 0), limits = c(-0.1, 100.1), breaks = seq(0, 100, by = 20)) +
    scale_x_discrete(expand = c(0, 0)) +
    theme(
        legend.text = element_text(), legend.position = "right",
        legend.title = element_blank(),
        axis.text.x = element_text(size = 6),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank()
    ) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + # Remove Grid
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    theme(aspect.ratio = 3 / 1) +
    xlab("Sample")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig2/comm_composition_genus_Caproic_Acid_C1.pdf",
    plot = last_plot(),
    width = 4,
    height = 4
)

# Caproic_Acid_C2

plot_df_7 <- l6_otutab_long |>
    filter(C2 == 1)

plot_df_7$new_sample_nane <- factor(
    plot_df_7$new_sample_nane,
    levels = unique(plot_df_7$new_sample_nane[order(plot_df_7$day_factor)])
)

plot_df_7 |>
    ggplot(aes(
        x = new_sample_nane, y = Relative_Abundance, fill = Taxon,
        stratum = Taxon, alluvium = Taxon
    )) +
    theme_bw() +
    geom_col(
        width = 1,
        color = NA, size = 0.5, show.legend = F
    ) + # 去掉柱子的描边
    geom_vline(xintercept = c(2.5, 4.5, 6.5), color = "gray21", size = 0.35, linetype = "dashed") +
    scale_fill_manual(values = mycol) +
    scale_y_continuous(expand = c(0, 0), limits = c(-0.1, 100.1), breaks = seq(0, 100, by = 20)) +
    scale_x_discrete(expand = c(0, 0)) +
    theme(
        legend.text = element_text(), legend.position = "right",
        legend.title = element_blank(),
        axis.text.x = element_text(size = 6),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank()
    ) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + # Remove Grid
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    theme(aspect.ratio = 3 / 1) +
    xlab("Sample")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig2/comm_composition_genus_Caproic_Acid_C2.pdf",
    plot = last_plot(),
    width = 4,
    height = 4
)

# Caproic_Acid_C3

plot_df_8 <- l6_otutab_long |>
    filter(C3 == 1)

plot_df_8$new_sample_nane <- factor(
    plot_df_8$new_sample_nane,
    levels = unique(plot_df_8$new_sample_nane[order(plot_df_8$day_factor)])
)

plot_df_8 |>
    ggplot(aes(
        x = new_sample_nane, y = Relative_Abundance, fill = Taxon,
        stratum = Taxon, alluvium = Taxon
    )) +
    theme_bw() +
    geom_col(
        width = 1,
        color = NA, size = 0.5, show.legend = F
    ) + # 去掉柱子的描边
    geom_vline(xintercept = c(2.5, 4.5, 6.5), color = "gray21", size = 0.35, linetype = "dashed") +
    scale_fill_manual(values = mycol) +
    scale_y_continuous(expand = c(0, 0), limits = c(-0.1, 100.1), breaks = seq(0, 100, by = 20)) +
    scale_x_discrete(expand = c(0, 0)) +
    theme(
        legend.text = element_text(), legend.position = "right",
        legend.title = element_blank(),
        axis.text.x = element_text(size = 6),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank()
    ) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + # Remove Grid
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    theme(aspect.ratio = 3 / 1) +
    xlab("Sample")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig2/comm_composition_genus_Caproic_Acid_C3.pdf",
    plot = last_plot(),
    width = 4,
    height = 4
)

# Caprylic_Acid_CK

plot_df_9 <- l6_otutab_long |>
    filter(Caprylic_Acid_CK == 1)

plot_df_9$new_sample_nane <- factor(
    plot_df_9$new_sample_nane,
    levels = unique(plot_df_9$new_sample_nane[order(plot_df_9$day_factor)])
)

plot_df_9 |>
    ggplot(aes(
        x = new_sample_nane, y = Relative_Abundance, fill = Taxon,
        stratum = Taxon, alluvium = Taxon
    )) +
    theme_bw() +
    geom_col(
        width = 1,
        color = NA, size = 0.5
    ) + # 去掉柱子的描边
    geom_vline(xintercept = c(2.5, 4.5, 6.5), color = "gray21", size = 0.35, linetype = "dashed") +
    scale_fill_manual(values = mycol) +
    scale_y_continuous(expand = c(0, 0), limits = c(-0.1, 100.1), breaks = seq(0, 100, by = 10)) +
    scale_x_discrete(expand = c(0, 0)) +
    theme(
        legend.text = element_text(), legend.position = "right",
        legend.title = element_blank()
    ) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + # Remove Grid
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    theme(aspect.ratio = 4 / 3) +
    xlab("Sample") +
    ylab("Relative Abundace (%)")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig2/comm_composition_genus_Caprylic_Acid_CK.pdf",
    plot = last_plot(),
    width = 6,
    height = 4
)

# Caprylic_Acid_D1

plot_df_10 <- l6_otutab_long |>
    filter(D1 == 1)

plot_df_10$new_sample_nane <- factor(
    plot_df_10$new_sample_nane,
    levels = unique(plot_df_10$new_sample_nane[order(plot_df_10$day_factor)])
)

plot_df_10 |>
    ggplot(aes(
        x = new_sample_nane, y = Relative_Abundance, fill = Taxon,
        stratum = Taxon, alluvium = Taxon
    )) +
    theme_bw() +
    geom_col(
        width = 1,
        color = NA, size = 0.5, show.legend = F
    ) + # 去掉柱子的描边
    geom_vline(xintercept = c(2.5, 4.5, 6.5), color = "gray21", size = 0.35, linetype = "dashed") +
    scale_fill_manual(values = mycol) +
    scale_y_continuous(expand = c(0, 0), limits = c(-0.1, 100.1), breaks = seq(0, 100, by = 20)) +
    scale_x_discrete(expand = c(0, 0)) +
    theme(
        legend.text = element_text(), legend.position = "right",
        legend.title = element_blank(),
        axis.text.x = element_text(size = 6),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank()
    ) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + # Remove Grid
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    theme(aspect.ratio = 3 / 1) +
    xlab("Sample")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig2/comm_composition_genus_Caprylic_Acid_D1.pdf",
    plot = last_plot(),
    width = 4,
    height = 4
)

# Caprylic_Acid_D2

plot_df_11 <- l6_otutab_long |>
    filter(D2 == 1)

plot_df_11$new_sample_nane <- factor(
    plot_df_11$new_sample_nane,
    levels = unique(plot_df_11$new_sample_nane[order(plot_df_11$day_factor)])
)

plot_df_11 |>
    ggplot(aes(
        x = new_sample_nane, y = Relative_Abundance, fill = Taxon,
        stratum = Taxon, alluvium = Taxon
    )) +
    theme_bw() +
    geom_col(
        width = 1,
        color = NA, size = 0.5, show.legend = F
    ) + # 去掉柱子的描边
    geom_vline(xintercept = c(2.5, 4.5, 6.5), color = "gray21", size = 0.35, linetype = "dashed") +
    scale_fill_manual(values = mycol) +
    scale_y_continuous(expand = c(0, 0), limits = c(-0.1, 100.1), breaks = seq(0, 100, by = 20)) +
    scale_x_discrete(expand = c(0, 0)) +
    theme(
        legend.text = element_text(), legend.position = "right",
        legend.title = element_blank(),
        axis.text.x = element_text(size = 6),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank()
    ) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + # Remove Grid
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    theme(aspect.ratio = 3 / 1) +
    xlab("Sample")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig2/comm_composition_genus_Caprylic_Acid_D2.pdf",
    plot = last_plot(),
    width = 4,
    height = 4
)

# Caprylic_Acid_D3

plot_df_12 <- l6_otutab_long |>
    filter(D3 == 1)

plot_df_12$new_sample_nane <- factor(
    plot_df_12$new_sample_nane,
    levels = unique(plot_df_12$new_sample_nane[order(plot_df_12$day_factor)])
)

plot_df_12 |>
    ggplot(aes(
        x = new_sample_nane, y = Relative_Abundance, fill = Taxon,
        stratum = Taxon, alluvium = Taxon
    )) +
    theme_bw() +
    geom_col(
        width = 1,
        color = NA, size = 0.5, show.legend = F
    ) + # 去掉柱子的描边
    geom_vline(xintercept = c(2.5, 4.5, 6.5), color = "gray21", size = 0.35, linetype = "dashed") +
    scale_fill_manual(values = mycol) +
    scale_y_continuous(expand = c(0, 0), limits = c(-0.1, 100.1), breaks = seq(0, 100, by = 20)) +
    scale_x_discrete(expand = c(0, 0)) +
    theme(
        legend.text = element_text(), legend.position = "right",
        legend.title = element_blank(),
        axis.text.x = element_text(size = 6),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank()
    ) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + # Remove Grid
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    theme(aspect.ratio = 3 / 1) +
    xlab("Sample")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig2/comm_composition_genus_Caprylic_Acid_D3.pdf",
    plot = last_plot(),
    width = 4,
    height = 4
)
