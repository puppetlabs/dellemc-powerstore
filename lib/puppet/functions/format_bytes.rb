#
# to_bytes.rb
#
Puppet::Functions.create_function(:'format_bytes') do
  # Converts the bytes argument into a human-readable form, for example 1000000000 bytes becomes 1GB.
  # @param arg The integer or a string containing a byte size
  # @return a string containing a human-readable value
  # Takes a single integer value as an argument.
  dispatch :format_bytes do
    param 'Variant[Integer,String]', :bytes
  end

  def format_bytes(bytes)

    powers = {
      3 => "k",
      6 => "M",
      9 => "G",
      12 => "T",
      15 => "P",
      18 => "E",
    }

    bytes = bytes.to_i
    power = 0
    while bytes > 1000 do
      bytes /= 1000.0
      power += 3
    end

    "#{'%.2f' % bytes} #{powers[power]}B"
  end
end