resource "local_file" "prometheus_pk" {
  content         = tls_private_key.prometheus.private_key_pem
  filename        = "ansible/prometheus_pk.pem"
  file_permission = 600
}

resource "local_file" "ansible_hosts" {
  content = templatefile("templates/ansible_hosts", {
    PROMETHEUS_IP = aws_instance.prometheus_instance.public_ip
  })
  filename = "ansible/hosts"
}

output "prometheus_ip" {
  value = aws_instance.prometheus_instance.public_ip
}