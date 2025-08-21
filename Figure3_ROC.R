# 假设数据结构示例（请替换为你的实际数据）
# 1. 加载必要包

# 加载必要的包
if (!require(pacman)) install.packages("pacman")
pacman::p_load(pROC, ggplot2, dplyr, ggpubr, RColorBrewer, scales)
library(writexl)

###导入data


# 数据预处理
data <- data %>%
  mutate(
    Blood_CT_neg = -Blood_CT,
    Balf_CT_neg = -Balf_CT,
    Group = factor(Group, levels = c("PJC", "PJP"))  # PJP为阳性组
  )

# 计算ROC曲线
roc_blood_mNGS <- roc(Group ~ Blood_mNGS, data, direction = "<", ci = TRUE)
roc_Balf_mNGS <- roc(Group ~ Balf_mNGS, data, direction = "<", ci = TRUE)
roc_blood_CT <- roc(Group ~ Blood_CT_neg, data, direction = "<", ci = TRUE)
roc_balf_CT <- roc(Group ~ Balf_CT_neg, data, direction = "<", ci = TRUE)

# 创建ROC数据框
roc_data <- rbind(
  data.frame(
    Sensitivity = roc_blood_mNGS$sensitivities,
    Specificity = roc_blood_mNGS$specificities,
    Indicator = "Blood mNGS",
    AUC = sprintf("%.2f (%.2f-%.2f)", roc_blood_mNGS$auc, roc_blood_mNGS$ci[1], roc_blood_mNGS$ci[3])
  ),
  data.frame(
    Sensitivity = roc_Balf_mNGS$sensitivities,
    Specificity = roc_Balf_mNGS$specificities,
    Indicator = "BALF mNGS",
    AUC = sprintf("%.2f (%.2f-%.2f)", roc_Balf_mNGS$auc, roc_Balf_mNGS$ci[1], roc_Balf_mNGS$ci[3])
  ),
  data.frame(
    Sensitivity = roc_blood_CT$sensitivities,
    Specificity = roc_blood_CT$specificities,
    Indicator = "Blood PCR",
    AUC = sprintf("%.2f (%.2f-%.2f)", roc_blood_CT$auc, roc_blood_CT$ci[1], roc_blood_CT$ci[3])
  ),
  data.frame(
    Sensitivity = roc_balf_CT$sensitivities,
    Specificity = roc_balf_CT$specificities,
    Indicator = "BALF PCR",
    AUC = sprintf("%.2f (%.2f-%.2f)", roc_balf_CT$auc, roc_balf_CT$ci[1], roc_balf_CT$ci[3])
  )
)

# 创建AUC标签数据（调整y坐标位置）
auc_labels <- unique(roc_data[, c("Indicator", "AUC")])
auc_labels$x <- 0.55  # x坐标位置
auc_labels$y <- seq(0.35, by = -0.08, length.out = 4)  # 调整y坐标位置，确保所有标签可见

# 确保标签顺序与曲线顺序一致
auc_labels <- auc_labels %>%
  mutate(Indicator = factor(Indicator, 
                            levels = c("Blood mNGS", "BALF mNGS", "Blood PCR", "BALF PCR")) %>%
           arrange(Indicator)
         
# 绘制ROC曲线
ggplot(roc_data, aes(x = 1 - Specificity, y = Sensitivity, 
                              color = Indicator, linetype = Indicator)) +
           geom_path(size = 1.0) +
           geom_abline(intercept = 0, slope = 1, linetype = "dashed", 
                       color = "gray50", size = 0.5) +
           scale_color_manual(values = c("Blood mNGS" = "#E41A1C", 
                                         "BALF mNGS" = "#377EB8", 
                                         "Blood PCR" = "#4DAF4A", 
                                         "BALF PCR" = "#984EA3")) +
           scale_linetype_manual(values = c("Blood mNGS" = "solid", 
                                            "BALF mNGS" = "solid", 
                                            "Blood PCR" = "dashed", 
                                            "BALF PCR" = "dashed")) +
           labs(x = "1 - Specificity", y = "Sensitivity") +
           coord_fixed(ratio = 1, xlim = c(0, 1), ylim = c(0, 1), expand = FALSE) +
           scale_x_continuous(breaks = seq(0, 1, 0.2)) +
           scale_y_continuous(breaks = seq(0, 1, 0.2)) +
           theme_classic(base_size = 12) +
           theme(
             axis.line = element_line(color = "black", size = 0.5),
             axis.ticks = element_line(color = "black", size = 0.5),
             axis.title = element_text(size = 12, face = "bold"),
             axis.text = element_text(size = 10, color = "black"),
             plot.margin = unit(c(0.5, 2.5, 0.5, 0.5), "cm"),
             aspect.ratio = 1,
             legend.position = "none"
           ) +
           # 添加AUC标签（确保颜色和顺序正确）
           annotate("text", 
                    x = auc_labels$x, 
                    y = auc_labels$y,
                    label = paste(auc_labels$Indicator, auc_labels$AUC),
                    color = c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3"),
                    hjust = 0,
                    size = 3.5,
                    fontface = "bold")

# ==================== 截断值分析 ====================
# 计算最佳截断值
cutoff_results <- data.frame()

add_cutoff <- function(roc_obj, name, is_ct = FALSE) {
  best <- coords(roc_obj, "best", best.method = "youden", transpose = TRUE)
  cutoff_value <- if (is_ct) -best["threshold"] else best["threshold"]
  
  data.frame(
    Biomarker = name,
    `Cutoff Value` = cutoff_value,
    Sensitivity = best["sensitivity"],
    Specificity = best["specificity"],
    `Original CT` = if (is_ct) cutoff_value else NA
  )
}

cutoff_results <- rbind(
  add_cutoff(roc_blood_mNGS, "Blood mNGS"),
  add_cutoff(roc_Balf_mNGS, "BALF mNGS"),
  add_cutoff(roc_blood_CT, "Blood PCR", TRUE),
  add_cutoff(roc_balf_CT, "BALF PCR", TRUE)
)

# 导出到Excel
write_xlsx(cutoff_results, "ROC_Cutoff_Results.xlsx")

# 显示结果
cat("ROC分析结果已保存到: ROC_Cutoff_Results.xlsx\n")
cat("最佳截断值结果:\n")
print(cutoff_results)

