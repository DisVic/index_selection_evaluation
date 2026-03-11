import logging
import os
import re
import subprocess

from selection.index import Index
from selection.selection_algorithm import SelectionAlgorithm

# Parameter is passed to dexter command line tool.
# min_saving_percentage: The mimimum percentage that an index candidate must reduce the
#                        cost of a query to be selected
DEFAULT_PARAMETERS = {"min_saving_percentage": 5}


# This algorithm implementation serves as an adapter for the Dexter index selection tool
# developed by Andrew Kane. The adapter calls the pre-installed tool.
# An introductory blog post can be found at:
# https://medium.com/@ankane/introducing-dexter-the-automatic-indexer-for-postgres-5f8fa8b28f27
# and the source code is published at: https://github.com/ankane/dexter/
class DexterAlgorithm(SelectionAlgorithm):
    def __init__(self, database_connector, parameters):
        SelectionAlgorithm.__init__(
            self, database_connector, parameters, DEFAULT_PARAMETERS
        )

    def _get_search_path(self, benchmark_name):
        """Determine search_path based on benchmark type."""
        if benchmark_name:
            if "inmon" in benchmark_name.lower():
                return "tpcds_inmon, tpcds_dv, public"
            elif "datavault" in benchmark_name.lower() or "dv" in benchmark_name.lower():
                return "tpcds_dv, tpcds_inmon, public"
        return "public"

    def _parse_index_output(self, output_string, query):
        """Parse dexter output to extract index columns for any schema."""
        columns = []
        
        # Match index patterns for any schema: schema.table_name (column1, column2)
        # Schemas: public, tpcds_inmon, tpcds_dv
        pattern = r'(?:public|tpcds_inmon|tpcds_dv)\.([\w]+)\s*\(([^)]+)\)'
        matches = re.findall(pattern, output_string)
        
        for match in matches:
            table_name = match[0]
            column_names = [c.strip() for c in match[1].split(",")]
            
            for column_name in column_names:
                column_object = next(
                    (
                        c
                        for c in query.columns
                        if c.name == column_name and c.table.name == table_name
                    ),
                    None,
                )
                if column_object:
                    columns.append(column_object)
        
        return columns

    def _calculate_best_indexes(self, workload):
        min_percentage = self.parameters["min_saving_percentage"]
        database_name = self.database_connector.db_name
        benchmark_name = self.parameters.get("benchmark_name", None)
        search_path = self._get_search_path(benchmark_name)

        index_columns = []

        for query in workload.queries:
            query_text = self.database_connector._prepare_query(query)
            with open(".dexter_query.sql", "w", encoding="utf-8") as f:
                f.write(query_text)
            
            # Build dexter command with connection parameters
            # Use environment variable for password to avoid exposing in command line
            env = os.environ.copy()
            env["PGPASSWORD"] = "tpcds_password"
            
            command = (
                f'dexter -h localhost -p 5432 -U tpcds -d {database_name}'
                f' --min-cost-savings-pct {min_percentage}'
                f' --options "-c search_path={search_path}"'
                f' .dexter_query.sql'
            )
            self.database_connector.commit()
            p = subprocess.Popen(
                command,
                cwd=os.getcwd(),
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                shell=True,
                env=env,
            )
            with p.stdout:
                output_string = p.stdout.read().decode("utf-8", errors="ignore")
            p.wait()
            self.database_connector._cleanup_query(query)
            self.database_connector.commit()

            log_output = output_string.replace("\n", "")
            logging.debug(f"{query}: {log_output}")

            parsed_columns = self._parse_index_output(output_string, query)
            if parsed_columns and parsed_columns not in index_columns:
                index_columns.append(parsed_columns)
        
        return [Index(c) for c in index_columns]
