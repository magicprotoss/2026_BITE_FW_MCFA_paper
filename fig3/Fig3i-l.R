librarian::shelf(microeco, reticulate, ggplot2, hrbrthemes, cols4all, dplyr, tidyplots, ggrepel, ggsci, magrittr, readxl, tidyverse)

mags <- readRDS(file = "2026_BITE_FW_MCFA_paper/fig3/mags.rds.xz")

target_metabolite_by_mag_long <- readRDS(file = "2026_BITE_FW_MCFA_paper/fig3/target_metabolite_by_mag_long.rds.xz")

################################################################################
# Archaea (Methan production)
mags_arch <- mags$clone()
mags_arch$tax_table <- mags_arch$tax_table %>%
    filter(Domain == "Archaea")
mags_arch$tidy_dataset()

t2 <- trans_env$new(dataset = mags_arch, env_cols = c(5:11))
t2$cal_ordination(method = "dbRDA", use_measure = "bray", taxa_level = "OTU")
t2$trans_ordination(adjust_arrow_length = TRUE, max_perc_env = 1.5)
t2[["res_ordination_trans"]][["eigval"]]
# dbRDA1           dbRDA2           dbRDA3           dbRDA4           dbRDA5           dbRDA6           dbRDA7
# "dbRDA1 [41.7%]" "dbRDA2 [30.3%]"           "10.5"            "9.8"            "3.9"            "2.6"            "1.1"

points_df <- t2[["res_ordination_trans"]][["df_sites"]]
arrows_df <- t2[["res_ordination_trans"]]$df_arrows

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
    scale_x_continuous(limits = c(-2.2, 3.2), breaks = c(-2, -1, 0, 1, 2, 3)) +
    scale_y_continuous(limits = c(-2.2, 2.5)) +
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
    xlab("dbRDA 1 (41.7%)") +
    ylab("dbRDA 2 (30.3%)")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig3/fig3i.pdf",
    width = 4,
    height = 4
)

################################################################################

# Acetate-e0 Exchange Acetate 乙酸
acetate_producing_genomes <- target_metabolite_by_mag_long %>%
    filter(metabolite == "Acetate") %>%
    pull(genome) %>%
    unique()

mags_acetate <- mags$clone()
mags_acetate$otu_table <- mags_acetate$otu_table %>%
    rownames_to_column("rownames") %>%
    filter(rownames %in% acetate_producing_genomes) %>%
    column_to_rownames("rownames")
mags_acetate$tidy_dataset()

t3 <- trans_env$new(dataset = mags_acetate, env_cols = c(5:11))
t3$cal_ordination(method = "dbRDA", use_measure = "bray", taxa_level = "OTU")
t3$trans_ordination(adjust_arrow_length = TRUE, max_perc_env = 1.5)
t3[["res_ordination_trans"]][["eigval"]]
# dbRDA1           dbRDA2           dbRDA3           dbRDA4           dbRDA5           dbRDA6           dbRDA7
# "dbRDA1 [50.8%]" "dbRDA2 [27.9%]"           "10.3"            "5.2"            "2.9"            "1.9"              "1"

points_df <- t3[["res_ordination_trans"]][["df_sites"]]
arrows_df <- t3[["res_ordination_trans"]]$df_arrows

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
    scale_x_continuous(limits = c(-3, 2), breaks = c(-3, -2, -1, 0, 1, 2)) +
    scale_y_continuous(limits = c(-2, 3)) +
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
    xlab("dbRDA 1 (50.8%)") +
    ylab("dbRDA 2 (27.9%)")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig3/fig3j.pdf",
    width = 4,
    height = 4
)

# Butyrate-e0 Exchange Butyrate 丁酸
butyrate_producing_genomes <- target_metabolite_by_mag_long %>%
    filter(metabolite == "Butyrate") %>%
    pull(genome) %>%
    unique()

mags_butyrate <- mags$clone()
mags_butyrate$otu_table <- mags_butyrate$otu_table %>%
    rownames_to_column("rownames") %>%
    filter(rownames %in% butyrate_producing_genomes) %>%
    column_to_rownames("rownames")
mags_butyrate$tidy_dataset()

t4 <- trans_env$new(dataset = mags_butyrate, env_cols = c(5:11))
t4$cal_ordination(method = "dbRDA", use_measure = "bray", taxa_level = "OTU")
t4$trans_ordination(adjust_arrow_length = TRUE, max_perc_env = 1.5)
t4[["res_ordination_trans"]][["eigval"]]
# dbRDA1           dbRDA2           dbRDA3           dbRDA4           dbRDA5           dbRDA6           dbRDA7
# "dbRDA1 [52%]" "dbRDA2 [24.5%]"            "9.2"            "7.4"            "5.4"            "1.3"            "0.3"

points_df <- t4[["res_ordination_trans"]][["df_sites"]]
arrows_df <- t4[["res_ordination_trans"]]$df_arrows

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
    scale_x_continuous(limits = c(-2, 2.1)) +
    scale_y_continuous(limits = c(-2, 2)) +
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
    xlab("dbRDA 1 (52.0%)") +
    ylab("dbRDA 2 (24.5%)")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig3/fig3k.pdf",
    width = 4,
    height = 4
)

# Propionate-e0 Exchange Propionate 丙酸
propionate_producing_genomes <- target_metabolite_by_mag_long %>%
    filter(metabolite == "Propionate") %>%
    pull(genome) %>%
    unique()

mags_propionate <- mags$clone()
mags_propionate$otu_table <- mags_propionate$otu_table %>%
    rownames_to_column("rownames") %>%
    filter(rownames %in% propionate_producing_genomes) %>%
    column_to_rownames("rownames")
mags_propionate$tidy_dataset()

t5 <- trans_env$new(dataset = mags_propionate, env_cols = c(5:11))
t5$cal_ordination(method = "dbRDA", use_measure = "bray", taxa_level = "OTU")
t5$trans_ordination(adjust_arrow_length = TRUE, max_perc_env = 1.5)
t5[["res_ordination_trans"]][["eigval"]]
# dbRDA1           dbRDA2           dbRDA3           dbRDA4           dbRDA5           dbRDA6           dbRDA7
# "dbRDA1 [54.3%]" "dbRDA2 [20.2%]"           "11.8"            "8.3"            "3.7"            "1.3"            "0.4"

points_df <- t5[["res_ordination_trans"]][["df_sites"]]
arrows_df <- t5[["res_ordination_trans"]]$df_arrows

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
    scale_x_continuous(limits = c(-4, 4)) +
    scale_y_continuous(limits = c(-2, 3)) +
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
    xlab("dbRDA 1 (54.3%)") +
    ylab("dbRDA 2 (20.2%)")

ggsave(
    filename = "2026_BITE_FW_MCFA_paper/fig3/figl.pdf",
    width = 4,
    height = 4
)
