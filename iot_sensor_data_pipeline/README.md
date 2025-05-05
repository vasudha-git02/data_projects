# IoT Sensor Data Platform (Real-Time Streaming Pipeline)

This project simulates an end-to-end data engineering pipeline for IoT devices using AWS services.

## 💡 Project Summary
Simulated IoT devices send temperature and humidity readings to a Kinesis Data Stream. A Lambda function processes this data in real-time and stores it in S3. We use AWS Glue + Athena to query the data, and Power BI to visualize anomalies (e.g., overheating sensors).

## 🔧 Tech Stack
- Amazon Kinesis
- AWS Lambda
- Amazon S3
- AWS Glue Catalog
- Amazon Athena
- Power BI
- Python (data producer)

## 📊 Use Cases
- Real-time IoT sensor data ingestion
- Anomaly detection (e.g. temp > 75°C)
- Visualizing trends in sensor readings

## 📁 Project Structure
data_projects/
└── iot_sensor_data_pipeline/
    ├── producer/                   # Python script to simulate and push sensor data
    │   └── generate_sensor_data.py
    ├── lambda/                     # Lambda function code
    │   └── process_sensor_data.py
    ├── athena_queries/            # SQL queries for analysis
    │   └── temperature_summary.sql
    ├── glue_catalog/              # Glue table schema (if using JSON schema or code-based setup)
    ├── dashboards/                # Screenshots of Power BI dashboards (export as PNG)
    ├── architecture/              # Architecture diagram (e.g. PNG or .drawio)
    ├── sample_data/               # JSON files for sample sensor payloads
    └── README.md                  # Project overview, setup, and visualizations

## 🚀 Future Enhancements
- Redshift integration
- Alerting via SNS or email
- Daily batch summary pipelines
