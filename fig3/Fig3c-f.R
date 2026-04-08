librarian::shelf(microeco, reticulate, ggplot2, hrbrthemes, cols4all, dplyr, tidyplots, ggrepel, ggsci, magrittr, tidyverse)

mags <- readRDS(file = "2026_BITE_FW_MCFA_paper/fig3/mags.rds.xz")

target_metabolite_by_mag_long <- readRDS(file = "2026_BITE_FW_MCFA_paper/fig3/target_metabolite_by_mag_long.rds.xz")

################################################################################
# Archaea (Methan production)
mags_arch <- mags$clone()
mags_arch$tax_table <- mags_arch$tax_table %>%
    filter(Domain == "Archaea")
mags_arch$tidy_dataset()
mags_arch$cal_betadiv(unifrac = F)

beta_diversity_index <- trans_beta$new(
    dataset = mags_arch,
    group = "default_group",
    measure = "bray"
)
beta_diversity_index$cal_ordination(method = "PCoA")
coords <- beta_diversity_index$res_ordination$scores
#
beta_diversity_index$res_ordination$eig
# PCo1  PCo2  PCo3  PCo4  PCo5  PCo6  PCo7  PCo8  PCo9 PCo10 PCo11 PCo12 PCo13 PCo14 PCo15 PCo16 PCo17 PCo18 PCo19 PCo20 PCo21 PCo22 PCo23 PCo24 PCo25 PCo26
# 37.8  17.6

# ***好评
beta_diversity_index$cal_anosim(group = "default_group")
beta_diversity_index$res_anosim
# Test permutations statistic.R p.value Significance
# 1 ANOSIM for all groups          999   0.9279648   0.001          ***

coords |>
    ggplot(aes(x = PCo1, y = PCo2, color = add_acid_type_group, shape = factor(day), alpha = add_acid_conc_cat)) +
    geom_point(size = 2) +
    scale_color_locuszoom() +
    scale_fill_locuszoom() +
    scale_x_continuous(limits = c(-0.5, 0.5)) +
    scale_y_continuous(limits = c(-0.5, 0.5)) +
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
    xlab("PCoA 1 (37.8%)") +
    ylab("PCoA 2 (17.6%)")

ggsave("2026_BITE_FW_MCFA_paper/fig3/fig3c.pdf", width = 4, height = 4)

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
mags_acetate$cal_betadiv(unifrac = F)

beta_diversity_index <- trans_beta$new(
    dataset = mags_acetate,
    group = "default_group",
    measure = "bray"
)
beta_diversity_index$cal_ordination(method = "PCoA")
coords <- beta_diversity_index$res_ordination$scores
#
beta_diversity_index$res_ordination$eig
# PCo1  PCo2  PCo3  PCo4  PCo5  PCo6  PCo7  PCo8  PCo9 PCo10 PCo11 PCo12 PCo13 PCo14 PCo15 PCo16 PCo17 PCo18 PCo19 PCo20 PCo21 PCo22 PCo23
# 37.1  24.6   9.4   8.1   6.1   3.1   2.2   2.1   1.8   1.3   1.2   1.0   0.9   0.9   0.7   0.6   0.6   0.5   0.4   0.4   0.3   0.3   0.2
# PCo24 PCo25 PCo26 PCo27 PCo28 PCo29 PCo30 PCo31 PCo32 PCo33 PCo34 PCo35 PCo36 PCo37 PCo38 PCo39 PCo40 PCo41 PCo42 PCo43 PCo44 PCo45 PCo46
# 0.2   0.2   0.2   0.1   0.1   0.1   0.1   0.1   0.1   0.1   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0
# PCo47 PCo48 PCo49 PCo50 PCo51 PCo52 PCo53 PCo54 PCo55 PCo56 PCo57 PCo58 PCo59 PCo60 PCo61 PCo62 PCo63 PCo64 PCo65 PCo66 PCo67 PCo68
# 0.0   0.0   0.0  -0.1  -0.1  -0.1  -0.1  -0.1  -0.1  -0.1  -0.1  -0.1  -0.2  -0.2  -0.2  -0.2  -0.3  -0.3  -0.4  -0.4  -0.7  -0.9

# ***好评
beta_diversity_index$cal_anosim(group = "default_group")
beta_diversity_index$res_anosim
# Test permutations statistic.R p.value Significance
# 1 ANOSIM for all groups          999   0.9185541   0.001          ***

coords |>
    ggplot(aes(x = PCo1, y = PCo2, color = add_acid_type_group, shape = factor(day), alpha = add_acid_conc_cat)) +
    geom_point(size = 2) +
    scale_color_locuszoom() +
    scale_fill_locuszoom() +
    scale_x_continuous(limits = c(-0.6, 0.4)) +
    scale_y_continuous(limits = c(-0.6, 0.3), breaks = c(-0.6, -0.45, -0.3, -0.15, 0, 0.15, 0.3)) +
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
    xlab("PCoA 1 (37.1%)") +
    ylab("PCoA 2 (24.6%)")

ggsave("2026_BITE_FW_MCFA_paper/fig3/fig3d.pdf", width = 4, height = 4)

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
mags_propionate$cal_betadiv(unifrac = F)

beta_diversity_index <- trans_beta$new(
    dataset = mags_propionate,
    group = "default_group",
    measure = "bray"
)
beta_diversity_index$cal_ordination(method = "PCoA")
coords <- beta_diversity_index$res_ordination$scores
#
beta_diversity_index$res_ordination$eig
# PCo1  PCo2  PCo3  PCo4  PCo5  PCo6  PCo7  PCo8  PCo9 PCo10 PCo11 PCo12 PCo13 PCo14 PCo15 PCo16 PCo17 PCo18 PCo19 PCo20 PCo21 PCo22 PCo23
# 44.0  19.6  11.6   7.6   4.8   3.1   2.6   2.0   1.7   1.3   1.1   0.9   0.7   0.6   0.5   0.3   0.3   0.3   0.3   0.2   0.2   0.2   0.1
# ***好评
beta_diversity_index$cal_anosim(group = "default_group")
beta_diversity_index$res_anosim
# Test permutations statistic.R p.value Significance
# 1 ANOSIM for all groups          999   0.9442435   0.001          ***

coords |>
    ggplot(aes(x = PCo1, y = PCo2, color = add_acid_type_group, shape = factor(day), alpha = add_acid_conc_cat)) +
    geom_point(size = 2) +
    scale_color_locuszoom() +
    scale_fill_locuszoom() +
    scale_x_continuous(limits = c(-0.6, 0.6)) +
    scale_y_continuous(limits = c(-0.75, 0.25)) +
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
    xlab("PCoA 1 (44.0%)") +
    ylab("PCoA 2 (19.6%)")

ggsave("2026_BITE_FW_MCFA_paper/fig3/fig3e.pdf", width = 4, height = 4)

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
mags_butyrate$cal_betadiv(unifrac = F)

beta_diversity_index <- trans_beta$new(
    dataset = mags_butyrate,
    group = "default_group",
    measure = "bray"
)
beta_diversity_index$cal_ordination(method = "PCoA")
coords <- beta_diversity_index$res_ordination$scores
#
beta_diversity_index$res_ordination$eig
# PCo1  PCo2  PCo3  PCo4  PCo5  PCo6  PCo7  PCo8  PCo9 PCo10 PCo11 PCo12 PCo13 PCo14 PCo15 PCo16 PCo17 PCo18 PCo19 PCo20 PCo21 PCo22 PCo23
# 42.6  18.1  11.1   7.9   4.5   3.9   3.4   3.1   2.4   1.6   1.3   1.1   0.8   0.8   0.6   0.6   0.5   0.5   0.4   0.3   0.3   0.2   0.2
# ***好评
beta_diversity_index$cal_anosim(group = "default_group")
beta_diversity_index$res_anosim
# Test permutations statistic.R p.value Significance
# 1 ANOSIM for all groups          999   0.9420677   0.001          ***

coords |>
    ggplot(aes(x = PCo1, y = PCo2, color = add_acid_type_group, shape = factor(day), alpha = add_acid_conc_cat)) +
    geom_point(size = 2) +
    scale_color_locuszoom() +
    scale_fill_locuszoom() +
    scale_x_continuous(limits = c(-0.6, 0.6)) +
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
    xlab("PCoA 1 (42.6%)") +
    ylab("PCoA 2 (18.1%)")

ggsave("2026_BITE_FW_MCFA_paper/fig3/fig3f.pdf", width = 4, height = 4)
