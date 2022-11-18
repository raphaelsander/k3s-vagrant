require 'yaml'

env = YAML.load_file('env.yaml')

Vagrant.configure("2") do |config|

    env.each do |env|
        config.vm.define env['name'] do |host|

            host.vm.box = env['box']
            host.vm.hostname = env['hostname']
            host.vm.network 'public_network', ip: env['ipaddress']
        
            host.vm.provider 'virtualbox' do |v|
                v.name = env['name']
                v.memory = env['memory']
                v.cpus = env['cpu']
            end

            host.vm.provider "vmware_desktop" do |v|
                v.vmx["memsize"] = env['memory']
                v.vmx["numvcpus"] = env['cpu']
            end

            host.vm.provision "shell", path: env['provision']
        end
    end
end