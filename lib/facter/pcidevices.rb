if Facter.value(:kernel) == "Linux"
  devices = {}
  slot=""
  Facter::Util::Resolution.exec('lspci -v -mm -k').each_line do |line|
    if not line =~ /^$/ # We don't need to parse empty lines
      splitted = line.split(/\t/)
      # lspci has a nice syntax:
      # ATTRIBUTE:\tVALUE
      # We use this to fill our hash
      if splitted[0] =~ /^Slot:$/
        slot=splitted[1].chomp
        devices[slot] = {}
      else
        # The chop is needed to strip the ':' from the string
        devices[slot][splitted[0].chop] = splitted[1].chomp
      end
    end
  end
  # Fill array with available unique classes to iterate over later
  dev_classes = []
  devices.each_key do |devidentifier|
    if devices[devidentifier].has_key?("Class")
      if not dev_classes.include?(devices[devidentifier].fetch("Class"))
       dev_classes.push(devices[devidentifier].fetch("Class"))
      end
    end
  end
  dev_classes.each do |dev_class|
    dev_class_count = 0
    devices.each_key do |devidentifier|
      case devices[devidentifier].fetch("Class")
      when dev_class
        ["Vendor","Device","Driver"].each do |a|
          if devices[devidentifier].has_key?(a)
            Facter.add(:"#{devices[devidentifier].fetch("Class").downcase.gsub(' ','_')}_#{dev_class_count}_#{a.downcase}") do
              setcode do
                  devices[devidentifier].fetch(a)
              end
            end
          end
        end
        dev_class_count += 1
      end
    end
  end
end
