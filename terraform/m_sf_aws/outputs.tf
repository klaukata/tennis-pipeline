output "itegration_description" {
  depends_on  = [snowsql_exec.read_integration_description]
  description = "The SnowSQL query result from the read statements."
  value       = jsondecode(nonsensitive(snowsql_exec.read_integration_description.read_results))
}

output "format_path" {
  description = "A full path of a CVS file format"
  value       = local.format_full_path
}

output "stage_name" {
  value = snowflake_stage.stage.name
}