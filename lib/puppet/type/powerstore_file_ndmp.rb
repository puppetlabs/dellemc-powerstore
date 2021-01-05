require 'puppet/resource_api'

# rubocop:disable Style/StringLiterals

# The Network Data Management Protocol (NDMP) provides a standard for backing up file servers on a network. NDMP allows centralized applications to back up file servers that run on various platforms and platform versions. NDMP reduces network congestion by isolating control path traffic from data path traffic, which permits centrally managed and monitored local backup operations. Storage systems support NDMP v2-v4 over the network. Direct-attach NDMP is not supported. This means that the tape drives need to be connected to a media server, and the NAS server communicates with the media server over the network. NDMP has an advantage when using multiprotocol file systems because it backs up the Windows ACLs as well as the UNIX security information.
Puppet::ResourceApi.register_type(
  name: 'powerstore_file_ndmp',
  features: ['remote_resource'],
  # rubocop:disable Lint/UnneededDisable
  # rubocop:disable Layout/TrailingWhitespace
  desc: <<-EOS,
    The Network Data Management Protocol (NDMP) provides a standard for backing up file servers on a network. NDMP allows centralized applications to back up file servers that run on various platforms and platform versions. NDMP reduces network congestion by isolating control path traffic from data path traffic, which permits centrally managed and monitored local backup operations. Storage systems support NDMP v2-v4 over the network. Direct-attach NDMP is not supported. This means that the tape drives need to be connected to a media server, and the NAS server communicates with the media server over the network. NDMP has an advantage when using multiprotocol file systems because it backs up the Windows ACLs as well as the UNIX security information.
  EOS
  attributes:   {
    ensure:      {
      type:      "Enum['present', 'absent']",
      desc:      'Whether this resource should be present or absent on the target system.',
      default:   'present',
    },
    id:          {
      type:      "String",
      desc:      "Unique identifier of the NDMP service object.",
      behaviour: :namevar,
    },
    nas_server_id:          {
      type:      "Optional[String]",
      desc:      "Unique identifier of the NAS server to be configured with these NDMP settings.",
      behaviour: :init_only,
    },
    password:          {
      type:      "Optional[String]",
      desc:      "Password for the NDMP service user.",
    },
    user_name:          {
      type:      "Optional[String]",
      desc:      "User name for accessing the NDMP service.",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
