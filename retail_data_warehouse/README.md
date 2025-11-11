# 🏗️ Retail Data Warehouse Project

## 📘 Overview  
This project demonstrates an **end-to-end retail data warehouse pipeline** built using **PySpark, Parquet, and Power BI**, following **Kimball’s dimensional modeling principles**.  

The data simulates the **Olist E-commerce dataset (Brazil)** and showcases how to design, transform, and visualize data efficiently from staging to presentation layers.  
It highlights core data-engineering skills including ETL, star schema modeling, and interactive dashboarding.

---

## 🧱 Architecture

Raw Data (CSV Files)
↓
PySpark (ETL, Cleaning, Transformation)
↓
Parquet Files (Staging, Core, and Presentation Layers)
↓
Power BI (Dimensional Modeling & Visualization)

---


---

## 🧰 Tech Stack
| Layer | Tools / Services |
|--------|------------------|
| **Storage** | Local Parquet Files |
| **ETL / Processing** | PySpark |
| **Modeling Approach** | Kimball Dimensional Modeling (Star Schema) |
| **Visualization** | Power BI |
| **Version Control** | Git & GitHub |

---

## 📊 Power BI Dashboard – *Retail Sales Performance*

The Power BI dashboard visualizes the curated dataset generated from PySpark transformations and Kimball-modeled data warehouse layers.  
It delivers actionable insights across sales, customer behavior, and regional performance.

### **Key Highlights**
- 💰 **$14M total sales**, **99K orders**, and **119% YoY growth (2018 vs 2017)**  
- 🛍️ *Health & Beauty* and *Watches & Gifts* are the top-performing product categories  
- 🌎 **São Paulo**, **Rio de Janeiro**, and **Minas Gerais** lead in total sales  
- 💡 **Average order value ≈ $143**, **average review ≈ 4.1 stars**  
- 📦 **97%** of orders successfully delivered  

### **Dashboard Visuals**
| Visualization | Insight |
|----------------|----------|
| KPI Cards | Overall business metrics |
| Column Chart | Monthly sales trend |
| Line Chart | Average order value trend |
| Bar Chart | Top 10 product categories |
| Shape Map + DAX Card | Regional sales by state |
| Donut Chart | Order status distribution |
| DAX Measure | Year-over-year growth calculation |

📁 **Power BI File:** `Datawarehousing.pbix` ( `Datawarehousing.zip` , compressed)

---

## 🧮 Data Modeling  
The warehouse follows a **Kimball-style dimensional model (Star Schema)**, separating facts and dimensions for efficient analytics and scalability.

| Fact Table | Dimension Tables |
|-------------|------------------|
| `fact_orders` , `fact_orders_items` | `dim_customer`, `dim_seller`, `dim_product`, `dim_date` |

**Modeling Highlights**
- Created **surrogate keys** for dimension joins  
- Implemented **slowly changing dimension (Type 1)** behavior for historical attributes  
- Established clear **grain definition** for each fact table  
- Optimized for Power BI relationships and DAX performance  

---

## 🧩 Key Learnings
- Built a full **ETL → Data Warehouse → BI pipeline** locally using PySpark and Parquet  
- Designed and implemented a **Kimball-style star schema**  
- Practiced **data transformation, partitioning, and aggregation** in PySpark  
- Modeled and visualized insights using **Power BI with DAX measures**  
- Strengthened concepts of **data lineage, staging, and presentation layers**

---

## 🚀 Future Enhancements
- Migrate to a cloud data warehouse (e.g., AWS Redshift or Snowflake)  
- Automate Power BI refreshes using Power BI Service  
- Add orchestration via Apache Airflow  
- Integrate incremental load logic for scalability  

---

## 🧑‍💻 Author
**Vasudha Tanniru**  
*Database Developer | Aspiring Data Engineer*  
📍 Calgary, Canada  
🔗 [LinkedIn Profile](https://www.linkedin.com/in/vasudha-tanniru)

---

## 🖼️ Dashboard Preview  
<img width="1339" height="790" alt="image" src="https://github.com/user-attachments/assets/cebf9202-3d1f-4ee9-88bc-245b75da9fb7" />
