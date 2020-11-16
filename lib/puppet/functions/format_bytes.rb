#
# format_bytes.rb
#
Puppet::Functions.create_function(:format_bytes) do
  # @summary Converts the bytes argument into a human-readable form, for example 1000000000 bytes becomes 1GB.
  # @param bytes The size in bytes
  # @return A string containing a human-readable representation of bytes using the most appropriate unit
  dispatch :format_bytes do
    param 'Integer', :bytes
  end

  def format_bytes(bytes)
    powers = {
      3 => 'k',
      6 => 'M',
      9 => 'G',
      12 => 'T',
      15 => 'P',
      18 => 'E',
    }

    bytes = bytes.to_i
    power = 0
    while bytes > 1000
      bytes /= 1000.0
      power += 3
    end

    "#{'%.2f' % bytes} #{powers[power]}B"
  end
end
