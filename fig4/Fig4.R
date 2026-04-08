options(scipen = 999)

librarian::shelf(tidyverse, reticulate, ComplexHeatmap, circlize, cols4all, readxl)

ce_auxiliary_heatmap_data <- target_genes_abundance_per_sample_wr <- read_excel("2026_BITE_FW_MCFA_paper/fig4/data.xlsx",
    sheet = "gene_kegg_relative_abundance"
) |> column_to_rownames(var = "ko")

grouping_df <- as.data.frame(read_excel("2026_BITE_FW_MCFA_paper/fig4/data.xlsx",
    sheet = "grouping"
)) |> column_to_rownames(var = "sample_id")
grouping_df$group <- factor(grouping_df$group, levels = c("CK", "C4", "C6", "C8"))

gene_cat_mapping <- as.data.frame(read_excel("2026_BITE_FW_MCFA_paper/fig4/data.xlsx",
    sheet = "gene_cat_to_gene_mapping"
)) |> column_to_rownames(var = "ko")

gene_cat_mapping$gene_cat <- as.factor(gene_cat_mapping$gene_cat)

total_abun_log2 <- as.data.frame(read_excel("2026_BITE_FW_MCFA_paper/fig4/data.xlsx",
    sheet = "total_abundance_log2"
) |> column_to_rownames(var = "ko"))

ce_auxiliary_heatmap_data_zscaled <- t(scale(t(ce_auxiliary_heatmap_data)))

col_fun_z <- colorRamp2(seq(-2, 2, length.out = 6), c(
    "#1965B0",
    "#7BAFDE",
    "#CAE0AB",
    "#F7F056",
    "#FF7F0E",
    "#DC050C"
))

draw(Heatmap(as.matrix(ce_auxiliary_heatmap_data_zscaled),
    row_names_max_width = unit(15, "cm"),
    col = col_fun_z,
    border_gp = gpar(col = "gray5", lwd = 2),
    rect_gp = gpar(col = "gray95", lwd = 0.75),
    cluster_rows = F,
    cluster_columns = F,
    column_title = "",
    row_title = "",
    column_split = grouping_df[, 1],
    row_split = gene_cat_mapping[, 1],
    row_names_gp = gpar(fontsize = 8),
    column_names_gp = gpar(fontsize = 8),
    column_title_gp = gpar(fontsize = 8),
    row_title_gp = gpar(fontsize = 8),
    right_annotation = rowAnnotation(abundance = anno_barplot(total_abun_log2,
        gp = gpar(
            fill = "gray55",
            col = "gray55"
        ),
        width = unit(2, "cm")
    )),
    cell_fun = function(j, i, x, y, width, height, fill) {
        if (abs(ce_auxiliary_heatmap_data_zscaled[i, j]) > 2) {
            grid.text(sprintf("%.1f", ce_auxiliary_heatmap_data_zscaled[i, j]), x, y, gp = gpar(fontsize = 5, col = "gray91", fontface = "bold"))
        }
    }
))

draw(Legend(col_fun = col_fun_z, title = "zscore", legend_width = unit(4, "cm"), direction = "horizontal"))
