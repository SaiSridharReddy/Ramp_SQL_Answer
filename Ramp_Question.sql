WITH daily_totals AS (
    SELECT
        DATE(transaction_time) AS date,
        SUM(transaction_amount) AS total_amount
    FROM
        transactions
    GROUP BY
        DATE(transaction_time)
),
rolling_avg AS (
    SELECT
        date,
        AVG(total_amount) OVER (
            ORDER BY date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS rolling_3_day_avg
    FROM
        daily_totals
)
SELECT
    date,
    rolling_3_day_avg
FROM
    rolling_avg
WHERE
    date = '2021-01-31';
