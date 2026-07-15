# Amazon Sales Data Analysis

This repository contains three parts of the same Amazon sales project:

- `python_code/` - a local Python script for data analysis and KPI reporting
- `SQL/` - MySQL scripts and documentation for database-based analysis
- `Power BI/` - the Power BI dashboard, theme file, and dashboard assets

## Repository Layout

### Python
The Python project uses `pandas` to load the dataset, calculate KPIs, filter data, and export a summary report.

Run it locally from `python_code/`:

```bash
cd python_code
pip install -r requirements.txt
python app.py --csv "Amazon Sale Report.csv"
```

### SQL
The SQL folder includes:

- `load_dataset.sql`
- `project_setup.sql`
- `sql_code.sql`
- `amazon_sales_sql_analysis.docx`

Use these scripts to create the database, load the cleaned data, and run the analysis queries in MySQL.

### Power BI
The Power BI folder includes:

- `amazon_sales_dashboard.pbix`
- `amazon_theme_file.json`
- dashboard images and logo assets

Open the `.pbix` file in Power BI Desktop to view the dashboard and visuals.

## Notes

- The dataset file itself is not included in this repository, so you may need to place the CSV in the Python and SQL folders when running locally.
- Large files such as the Power BI workbook are included because they are part of the project deliverables.
