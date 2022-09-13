# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'libvirt'

Vagrant.configure("2") do |config|
    config.vm.define "devops" do |devops|
        devops.vm.box = "generic/ubuntu2004"
        devops.vm.hostname = "devops"
        devops.vm.provider :libvirt do |libvirt|
            libvirt.cpus = 4
            libvirt.memory = 4096
            libvirt.default_prefix = ""
        end

        devops.ssh.insert_key = false
        devops.ssh.private_key_path = ["~/.ssh/id_rsa", "~/.vagrant.d/insecure_private_key"]

        devops.vm.provision :ansible do |ansible|
            ansible.playbook = "./ansible/main.yml"
            ansible.tags = "wordpress,deploy_stacks"
        end
    end
end