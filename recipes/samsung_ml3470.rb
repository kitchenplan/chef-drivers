cookbook_file "Samsung ML-3470 Series.gz" do
  path "#{Chef::Config[:file_cache_path]}/Samsung ML-3470 Series.gz"
  action :create_if_missing
end

node['driver']['samsung_ml3470'].each do |samsung|
  execute 'Install Samsung printer: #{samsung['name']}' do
      command "lpadmin -p '#{samsung['name']}' -L '#{samsung['location']}' -E -v lpd://#{samsung['ip']} -P \"#{Chef::Config[:file_cache_path]}/Samsung ML-3470 Series.gz\" -o printer-is-shared=false"      
      not_if 'lpstat -v | grep -q "#{samsung['name']}"'
  end
end
