# Amazon Sales Data Analysis - Python Project

## Overview
This project is a local Python analysis script for Amazon sales data.
It uses `pandas` to clean the dataset, calculate KPIs, and print summary insights from the terminal.

## Features
- Loads Amazon sales data from a CSV file
- Calculates total orders, total revenue, and average order value
- Shows top SKUs, top states, fulfilment revenue, and B2B vs B2C split when available
- Exports the filtered dataset and a text summary to an output folder

## Tech Stack
- Python 3.x
- pandas

## Files
- `app.py` - local Python analysis script
- `Amazon Sale Report.csv` - input dataset

## Run Locally
1. Open this folder in a terminal.
2. Install the dependency:
   ```bash
   pip install pandas
   ```
3. Run the script:
   ```bash
   python app.py --csv "Amazon Sale Report.csv"
   ```

## Optional Filters
Filter by state or order status:
```bash
python app.py --csv "Amazon Sale Report.csv" --state Maharashtra --state Karnataka --status Delivered
```

## Output
The script creates an `output` folder with:
- `amazon_filtered.csv`
- `amazon_sales_report.txt`

## Resume Angle
You can describe this as a Python data analysis project built with `pandas` for sales cleaning, aggregation, and KPI reporting.

