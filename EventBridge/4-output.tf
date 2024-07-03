output "event_bridge_schedular" {
    value = aws_scheduler_schedule.rds_snapshot_schedule.schedule_expression
  
}