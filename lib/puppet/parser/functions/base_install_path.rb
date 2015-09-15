module Puppet::Parser::Functions
  newfunction(:default_install_path, :type  => :rvalue, :doc => <<-EOS
Returns the filename of a path
  EOS
  ) do |args|
    raise(Puppet::ParseError, "filename(): Wrong number of arguments " +
                                "given (#{args.size} for 1") if args.size == 2
    arch = lookupvar(':;architecture')
    source = args[0]
    major, minor = source.match(/(<?version>:\d+u\d+/)[0].split(/[uU]/)

    if arch == 'x86_64' && java_arch == 'i586'
      path = 'C:\Program Files (x86)\Java'
    else
      path = 'C:\Program Files\Java'
    end

    return File.basename(path)
  end
end