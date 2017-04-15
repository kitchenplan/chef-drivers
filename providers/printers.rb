def load_current_resource
  @printer = Chef::Resource::ApplicationsPackage.new(new_resource.name)
  Chef::Log.debug("Checking for printer #{new_resource.name}")
  installed = system("cat /etc/cups/printers.conf | grep #{new_resource.location}")
  @printer.installed(installed)
end


action :install do
    unless @printer.installed
        execute "Install #{new_resource.name}" do
            command   %{lpadmin -p "#{new_resource.name}" -L "#{new_resource.location}" -E -v lpd://#{new_resource.ip} -P "/opt/kitchenplan/vendor/cookbooks/drivers/templates/default/#{new_resource.driver}"}
        end
        execute "Unshare #{new_resource.name}" do
            command   %{lpadmin -p "#{new_resource.name}" -o printer-is-shared=false}
        end
     new_resource.updated_by_last_action(true)
    end
end
