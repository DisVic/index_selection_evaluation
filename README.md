# Index Selection Evaluation
## Usage

Install script:
* `./scripts/install.sh`

Deploy DBs using pregenerated raw data with Docker 
* `./deploy.sh`
* `docker exec -i tpcds_postgres psql -U tpcds -d tpcds < drop_pks.sql`

Run index selection evaluation for different DBs model paradigms:
* `python -m selection example_configs/config_tpcds_kimball.json`
* `python -m selection example_configs/config_tpcds_inmon.json`
* `python -m selection example_configs/config_tpcds_datavault.json`
