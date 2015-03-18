cookbook_file "Samsung_CLX_4190.ppd" do
  path "#{Chef::Config[:file_cache_path]}/Samsung_CLX_4190.ppd"
  action :create_if_missing
end

node['drivers']['samsung_clx4190'].each do |samsung|
  execute "Install Samsung printer: #{samsung['name']}" do
      command "lpadmin -p '#{samsung['name']}' -L '#{samsung['location']}' -E -v lpd://#{samsung['ip']} -P \"#{Chef::Config[:file_cache_path]}/Samsung_CLX_4190.ppd\" -o printer-is-shared=false"
      not_if 'lpstat -v | grep -q "#{samsung['name']}"'
  end
end
