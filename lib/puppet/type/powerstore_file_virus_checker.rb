require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_file_virus_checker',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    Use these resource types to manage the virus checker service of a NAS server. A virus checker instance is created each time the anti-virus service is enabled on a NAS server. A configuration file (named viruschecker.conf) needs to be uploaded before enabling the anti-virus service.
The cluster supports third-party anti-virus servers that perform virus scans and reports back to the storage system. For example, when an SMB client creates, moves, or modifies a file, the NAS server invokes the anti-virus server to scan the file for known viruses. During the scan any access to this file is blocked. If the file does not contain a virus, it is written to the file system. If the file is infected, corrective action (fixed, removed or placed in quarantine) is taken as defined by the anti-virus server. You can optionally set up the service to scan the file on read access based on last access of the file compared to last update of the third-party anti-virus date.

  EOS
  attributes:   {
    ensure:      {
      type:      "Enum['present', 'absent']",
      desc:      "Whether this resource should be present or absent on the target system.",
      default:   "present",
    },
    id:          { 
      type:      "String",
      desc:      "Unique identifier of the virus checker instance.",
      behaviour: :namevar,
    },
    is_config_file_uploaded:          { 
      type:      "Optional[Boolean]",
      desc:      "Indicates whether a virus checker configuration file has been uploaded.",
      default:   false,
    },
    is_enabled:          { 
      type:      "Optional[Boolean]",
      desc:      "Indicates whether the anti-virus service is enabled on this NAS server. Value are:- true - Anti-virus service is enabled. Each file created or modified by an SMB client is scanned by the third-party anti-virus servers. If a virus is detected, the access to the file system is denied. If third-party anti-virus servers are not available, according the policy, the access to the file systems is denied to prevent potential viruses propagation.- false - Anti-virus service is disabled. File systems of the NAS servers are available for access without virus checking.",
    },
    nas_server_id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of an associated NAS Server instance that uses this virus checker configuration. Only one virus checker configuration per NAS Server is supported.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
