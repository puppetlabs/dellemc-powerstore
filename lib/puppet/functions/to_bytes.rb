#
# to_bytes.rb
#
Puppet::Functions.create_function(:'to_bytes') do
  # Converts the argument into bytes, for example 4 kB becomes 4096.
  # @param arg The string containing a byte size
  # @return converted value into bytes
  # Takes a single string value as an argument.
  # Supports both decimal and binary multiples: 1 MB = 1000 KB and 1 MiB = 1024 KiB.
  dispatch :to_bytes do
    param 'String', :arg
  end

  def to_bytes(arg)
    # raise(Puppet::ParseError, "to_bytes(): Wrong number of arguments given (#{arguments.size} for 1)") if arguments.size != 1

    return arg if arg.is_a? Numeric

    value, prefix = *%r{([0-9.e+-]*)\s*([^bB]{1,2})}.match(arg)[1, 2]

    value = value.to_f
    # binding.pry
    case prefix.downcase
    when '' then return value.to_i
    when 'ki' then return (value * (1 << 10)).to_i
    when 'mi' then return (value * (1 << 20)).to_i
    when 'gi' then return (value * (1 << 30)).to_i
    when 'ti' then return (value * (1 << 40)).to_i
    when 'pi' then return (value * (1 << 50)).to_i
    when 'ei' then return (value * (1 << 60)).to_i
    when 'k' then return (value * 10 ** 3).to_i
    when 'm' then return (value * 10 ** 6).to_i
    when 'g' then return (value * 10 ** 9).to_i
    when 't' then return (value * 10 ** 12).to_i
    when 'p' then return (value * 10 ** 15).to_i
    when 'e' then return (value * 10 ** 18).to_i
    else raise Puppet::ParseError, "to_bytes(): Unknown prefix #{prefix}"
    end
  end
end