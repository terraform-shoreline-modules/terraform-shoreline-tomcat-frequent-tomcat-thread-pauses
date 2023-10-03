resource "shoreline_notebook" "frequent_tomcat_thread_pauses" {
  name       = "frequent_tomcat_thread_pauses"
  data       = file("${path.module}/data/frequent_tomcat_thread_pauses.json")
  depends_on = [shoreline_action.invoke_memory_allocation_adjustment]
}

resource "shoreline_file" "memory_allocation_adjustment" {
  name             = "memory_allocation_adjustment"
  input_file       = "${path.module}/data/memory_allocation_adjustment.sh"
  md5              = filemd5("${path.module}/data/memory_allocation_adjustment.sh")
  description      = "Increase the memory allocation of the JVM to ensure that there is enough memory available for the Tomcat server to run efficiently."
  destination_path = "/agent/scripts/memory_allocation_adjustment.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_memory_allocation_adjustment" {
  name        = "invoke_memory_allocation_adjustment"
  description = "Increase the memory allocation of the JVM to ensure that there is enough memory available for the Tomcat server to run efficiently."
  command     = "`chmod +x /agent/scripts/memory_allocation_adjustment.sh && /agent/scripts/memory_allocation_adjustment.sh`"
  params      = ["NEW_MEMORY_SIZE","PATH_TO_TOMCAT_DIRECTORY"]
  file_deps   = ["memory_allocation_adjustment"]
  enabled     = true
  depends_on  = [shoreline_file.memory_allocation_adjustment]
}

