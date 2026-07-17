# Summary of Findings

This summary was generated from the SQL analysis and dashboard results in this project. Every figure below was verified against the underlying query output before inclusion.

Northline Retail's historical order data shows a late delivery rate of 59.67% across 10,999 orders. Two of the three risk factors proposed in the business case, warehouse block and shipment mode, showed no meaningful relationship to delay. Late rates stayed within a narrow 57% to 62% band across all five warehouse blocks and all three shipment modes, meaning neither factor helps predict which orders will be late.

Discount level was different. Every order with a discount above 10% was late, with no exceptions across the full range of discount values in the dataset. Orders at 10% discount or below had a late rate close to the overall average, around 45% to 48%. This threshold is sharp enough that discount above 10% acts as a reliable, standalone predictor of lateness in this dataset.

Although this result proved reliable for indicating late deliveries, it only applies to 24% of total order volume. Compared to all late orders, this rule accounts for only about 40% of them. The remaining 60% happen outside this indicator. This is the main limitation of this analysis, since the available data does not explain what drives delay in most late orders.

Weight showed a relationship opposite to what the business case assumed going in. Late orders were lighter on average (3,273 grams) than on-time orders (4,169 grams). Heavier orders were not the delay risk originally suspected.

Based on these findings, the risk-flag mechanism proposed in the to-be process should use discount level, not weight or warehouse block, as its primary input. It will catch a meaningful share of at-risk orders reliably, but it will not catch most of them. The remaining delays are likely driven by factors this dataset does not capture, such as fulfilment issues on the warehouse floor, which the as-is process analysis identified as a separate, unmeasured source of delay. As a practical next step, the discount threshold should be re-tested periodically against new order data, since it was derived from a historical snapshot and may shift if discount policy changes. A correlation or feature selection analysis across all available fields would also help identify which other factors, if any, contribute to the remaining 60% of delays not explained by discount.
