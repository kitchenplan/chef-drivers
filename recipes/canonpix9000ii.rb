unless File.exists?("#{Chef::Config[:file_cache_path]}/#{node['drivers']['canon']['pixma9000ii']['dmg_filename']}")
    remote_file "#{Chef::Config[:file_cache_path]}/#{node['drivers']['canon']['pixma9000ii']['dmg_filename']}" do
        source "#{node['drivers']['canon']['pixma9000ii']['dmg_remote']}"
        checksum node['drivers']['canon']['pixma9000ii']['dmg_checksum']
        owner node['current_user']
    end
end

execute "attach #{node['drivers']['canon']['pixma9000ii']['dmg_filename']}" do
    command "hdiutil attach '#{Chef::Config[:file_cache_path]}/#{node['drivers']['canon']['pixma9000ii']['dmg_filename']}'"
    user node['current_user']
    not_if "lpstat -v | grep -q '#{node['drivers']['canon']['pixma9000ii']['printer_name_grep']}'"
end

execute "install Pro 9000ii" do
    command "installer -verboseR -pkg \"/Volumes/#{node['drivers']['canon']['pixma9000ii']['mount_name']}/#{node['drivers']['canon']['pixma9000ii']['installer_pkg']}\" -target /"
    not_if "lpstat -v | grep -q '#{node['drivers']['canon']['pixma9000ii']['printer_name_grep']}'"
end

execute "detach mcpd-mac-pro9000ii-10_89_2_0-ea13.dmg" do
    command "hdiutil detach \"/Volumes/#{node['drivers']['canon']['pixma9000ii']['mount_name']}/\""
    user node['current_user']
    only_if "mount | grep -q '#{node['drivers']['canon']['pixma9000ii']['mount_name']}'"
end
