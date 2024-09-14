output "itegration_description" {
  depends_on = [ snowsql_exec.read_integration_description ]
  description = "The SnowSQL query result from the read statements."
  value = jsondecode(nonsensitive(snowsql_exec.read_integration_description.read_results))
}
