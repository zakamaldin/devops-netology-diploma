data "yandex_compute_image" "image" {
  family = "fedora-35"
}

resource "yandex_compute_instance" "jenkins_master" {
    name = "jenkins-master"
    platform_id = "standard-v1"
    
    resources {
        cores         = 8
        memory        = 16
        core_fraction = 100
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.vpc_subnet_public_a.id
        nat       = true
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.image.image_id
            type = "network-hdd"
            size = 10
        }
    }   

    scheduling_policy { preemptible = true }

    metadata = {
        serial-port-enable = 1
        ssh-keys           = "fedora:${var.vms_ssh_root_key}"
    }
  allow_stopping_for_update = true
}

resource "yandex_compute_instance" "jenkins_agents" {
    count = 3
    name = "jenkins-node-${count.index + 1}"
    platform_id = "standard-v1"
    
    resources {
        cores         = 8
        memory        = 16
        core_fraction = 100
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.vpc_subnet_public_a.id
        nat       = true
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.image.image_id
            type = "network-hdd"
            size = 10
        }
    }   

    scheduling_policy { preemptible = true }

    metadata = {
        serial-port-enable = 1
        ssh-keys           = "fedora:${var.vms_ssh_root_key}"
    }
  allow_stopping_for_update = true
}

resource "local_file" "jenkins_hosts_inventory" {
    depends_on = [ yandex_compute_instance.jenkins_master, yandex_compute_instance.jenkins_agents ]
    content = templatefile("${path.module}/jenkins//hosts.tftpl",
        { 
            jenkins_master = yandex_compute_instance.jenkins_master,
            jenkins_agents  = yandex_compute_instance.jenkins_agents
        }
    )

  filename = "${abspath(path.module)}/jenkins/inventory/jenkins/hosts.yml"
}
