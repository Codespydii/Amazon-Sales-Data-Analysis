from __future__ import annotations

import argparse
from pathlib import Path

import pandas as pd


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Run a local Amazon sales analysis using Python and pandas."
    )
    parser.add_argument(
        "--csv",
        default="Amazon Sale Report.csv",
        help="Path to the Amazon sales CSV file.",
    )
    parser.add_argument(
        "--state",
        action="append",
        default=[],
        help="Filter by ship-state. Use multiple times for multiple states.",
    )
    parser.add_argument(
        "--status",
        action="append",
        default=[],
        help="Filter by order status. Use multiple times for multiple statuses.",
    )
    parser.add_argument(
        "--output-dir",
        default="output",
        help="Directory for exported reports and filtered data.",
    )
    return parser.parse_args()


def load_dataset(csv_path: Path) -> pd.DataFrame:
    if not csv_path.exists():
        raise FileNotFoundError(f"CSV file not found: {csv_path}")

    dataframe = pd.read_csv(csv_path)
    if "Total_Revenue" not in dataframe.columns:
        dataframe["Amount"] = pd.to_numeric(dataframe["Amount"], errors="coerce").fillna(0)
        dataframe["Qty"] = pd.to_numeric(dataframe["Qty"], errors="coerce").fillna(0)
        dataframe["Total_Revenue"] = dataframe["Qty"] * dataframe["Amount"]

    return dataframe


def apply_filters(
    dataframe: pd.DataFrame,
    states: list[str],
    statuses: list[str],
) -> pd.DataFrame:
    filtered = dataframe

    if states and "ship-state" in filtered.columns:
        filtered = filtered[filtered["ship-state"].isin(states)]

    if statuses and "Status" in filtered.columns:
        filtered = filtered[filtered["Status"].isin(statuses)]

    return filtered.copy()


def print_report(dataframe: pd.DataFrame) -> None:
    total_orders = dataframe["Order ID"].nunique() if "Order ID" in dataframe.columns else len(dataframe)
    total_revenue = dataframe["Total_Revenue"].sum()
    avg_order_value = dataframe["Total_Revenue"].mean()

    print("\nAmazon Sales Analysis")
    print("=" * 60)
    print(f"Total orders: {total_orders:,}")
    print(f"Total revenue: {total_revenue:,.2f}")
    print(f"Average order value: {avg_order_value:,.2f}")

    if "SKU" in dataframe.columns:
        top_skus = (
            dataframe.groupby("SKU", dropna=False)["Total_Revenue"]
            .sum()
            .sort_values(ascending=False)
            .head(10)
        )
        print("\nTop 10 SKUs by revenue")
        print(top_skus.to_string())

    if "ship-state" in dataframe.columns:
        state_revenue = (
            dataframe.groupby("ship-state", dropna=False)["Total_Revenue"]
            .sum()
            .sort_values(ascending=False)
            .head(10)
        )
        print("\nTop 10 states by revenue")
        print(state_revenue.to_string())

    if "Fulfilment" in dataframe.columns:
        fulfilment_revenue = dataframe.groupby("Fulfilment", dropna=False)["Total_Revenue"].sum()
        print("\nRevenue by fulfilment channel")
        print(fulfilment_revenue.to_string())

    if "B2B" in dataframe.columns:
        b2b_revenue = dataframe.groupby("B2B", dropna=False)["Total_Revenue"].sum()
        print("\nB2B vs B2C revenue split")
        print(b2b_revenue.to_string())


def export_outputs(dataframe: pd.DataFrame, output_dir: Path) -> None:
    output_dir.mkdir(parents=True, exist_ok=True)

    filtered_csv = output_dir / "amazon_filtered.csv"
    report_txt = output_dir / "amazon_sales_report.txt"

    dataframe.to_csv(filtered_csv, index=False)

    total_orders = dataframe["Order ID"].nunique() if "Order ID" in dataframe.columns else len(dataframe)
    total_revenue = dataframe["Total_Revenue"].sum()
    avg_order_value = dataframe["Total_Revenue"].mean()

    lines = [
        "Amazon Sales Analysis",
        "=" * 60,
        f"Total orders: {total_orders:,}",
        f"Total revenue: {total_revenue:,.2f}",
        f"Average order value: {avg_order_value:,.2f}",
        "",
        f"Filtered rows exported to: {filtered_csv}",
    ]
    report_txt.write_text("\n".join(lines), encoding="utf-8")

    print(f"\nFiltered CSV saved to: {filtered_csv}")
    print(f"Summary report saved to: {report_txt}")


def main() -> None:
    args = parse_args()
    csv_path = Path(args.csv)
    output_dir = Path(args.output_dir)

    dataframe = load_dataset(csv_path)
    filtered = apply_filters(dataframe, args.state, args.status)

    if filtered.empty:
        print("No rows matched the selected filters.")
        return

    print_report(filtered)
    export_outputs(filtered, output_dir)


if __name__ == "__main__":
    main()
