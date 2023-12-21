#CREATING SQS QUEUE AND DEADLETTER QUEUE
resource "aws_sqs_queue" "TA_deadletter_queue" {
  count = var.sqsFlag
  name                  = "IFCS_${replace(upper(var.env_ns),"-","_")}_TA_DeadLetter.fifo"
  fifo_queue            = true
  content_based_deduplication = false
}

resource "aws_sqs_queue" "TA_queue" {
  count = var.sqsFlag
  name                      = "IFCS_${replace(upper(var.env_ns),"-","_")}_TA.fifo"
  fifo_queue            = true
  content_based_deduplication = true
  redrive_policy = jsonencode({
    deadLetterTargetArn = "${aws_sqs_queue.TA_deadletter_queue.0.arn}"
    maxReceiveCount     = "${var.TA_deadletter_maxReceiveCount}"
  })
  
}

resource "aws_sqs_queue" "COMPLETION_deadletter_queue" {
  count = var.sqsFlag
  name                  = "IFCS_${replace(upper(var.env_ns),"-","_")}_COMPLETION_DeadLetter.fifo"
  fifo_queue            = true
  content_based_deduplication = false
}

resource "aws_sqs_queue" "COMPLETION_queue" {
  count = var.sqsFlag
  name                      = "IFCS_${replace(upper(var.env_ns),"-","_")}_COMPLETION.fifo"
  fifo_queue            = true
  content_based_deduplication = true
  redrive_policy = jsonencode({
    deadLetterTargetArn = "${aws_sqs_queue.COMPLETION_deadletter_queue.0.arn}"
    maxReceiveCount     = "${var.COMPLETION_deadletter_maxReceiveCount}"
  })
  
}