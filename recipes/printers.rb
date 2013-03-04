node["drivers"]["printers"].each do |printer|
  drivers_printers printer["name"] do
    name printer["name"]
    location printer["location"]
    ip printer["ip"]
    driver printer["driver"]
  end
end
