require 'tmpdir'

Facter.add(:windows_java_temp) do
  setcode {
    (ENV['TEMP'] || Dir.tmpdir).gsub(/\\\s/, " ").gsub(/\//, '\\')
  }
end