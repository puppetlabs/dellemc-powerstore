require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_import_session',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    Use the import_session resource type to initiate and manage the migration of volumes and consistency groups from a heritage Dell EMC storage system to a PowerStore storage system. The import is non-disruptive to hosts that access the volume during the import. The import process runs as a background job. Clients should poll the job status until the import completes.   Note: In these descriptions, LUNs are referred to as volumes and storage arrays are referred to as storage systems.
  EOS
  attributes:   {
    ensure:      {
      type:      "Enum['present', 'absent']",
      desc:      "Whether this resource should be present or absent on the target system.",
      default:   "present",
    },
    automatic_cutover:          { 
      type:      "Optional[Boolean]",
      desc:      "Indicates whether the import session cutover is manual (true) or automatic (false).",
      behaviour: :init_only,
    },
    average_transfer_rate:          { 
      type:      "Optional[Integer[0,9223372036854775807]]",
      desc:      "Average transfer rate of a data import operation in bytes/sec over the whole copy period. Before and after the import is in the Copy_In_Progress state, this value is null.",
    },
    current_transfer_rate:          { 
      type:      "Optional[Integer[0,9223372036854775807]]",
      desc:      "Current transfer rate of a data import operation in bytes/sec. Before and after the import is in the Copy_In_Progress state, this value is null.",
    },
    description:          { 
      type:      "Optional[String[0,128]]",
      desc:      "Description of the import session. The name can contain a maximum of 128 unicode characters. It cannot contain unprintable characters.",
      behaviour: :init_only,
    },
    destination_resource_id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the destination volume or volume group created as part of the import process.",
    },
    destination_resource_type:          { 
      type:      "Optional[Enum['volume','volume_group']]",
      desc:      "Storage resource type of the import destination. Values are: * volume - The destination resource of the import session is a volume. * volume_group - The destination resource of the import session is a volume group.",
    },
    destination_resource_type_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to destination_resource_type",
    },
    error:          { 
      type:      "Optional[Struct[{Optional[arguments] => Optional[Array[String]], Optional[code] => Optional[String], Optional[message_l10n] => Optional[String], }]]",
      desc:      "Filtering on the fields of this embedded resource is not supported.",
    },
    estimated_completion_timestamp:          { 
      type:      "Optional[String]",
      desc:      "When the import is in the Copy_In_Progress state, this value indicates the estimated time at which the data copy will complete. Before the import is in the Copy_In_Progress state, the value is null.",
    },
    id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the import session",
      behaviour: :read_only,
    },
    last_update_timestamp:          { 
      type:      "Optional[String]",
      desc:      "Date and time when was the import was last updated. This value is updated each time the import job updates.",
    },
    name:          { 
      type:      "String[0,128]",
      desc:      "Name of the import session. The name must be unique in the PowerStore cluster and can contain a maximum of 128 unicode characters. It cannot contain special HTTP characters, unprintable characters, or white space.",
      behaviour: :namevar,
    },
    parent_session_id:          { 
      type:      "Optional[String]",
      desc:      "For a volume that is part of a consistency group import, this value is the session identifier of the import session. For an individual volume import, this value is null.",
    },
    progress_percentage:          { 
      type:      "Optional[Integer[0,2147483647]]",
      desc:      "When the import is in the Copy_In_Progress state, this value indicates the completion percent for the import. Before the import is in the Copy_In_Progress state, this value is 0. After the cutover or if there is a failure, this value is null.",
    },
    protection_policy_id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the protection policy that will be applied to an imported volume or consistency group after the import completes. Only snapshot policies are supported in an import. Once the import completes, you can add a replication policy. If you try to import a replication policy, the import job will fail.",
      behaviour: :init_only,
    },
    remote_system_id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the storage system that contains the source volume or consistency group to be imported. You can query the source volume or consistency group object to get the identifier of the source system that the volume or consistency group are part of. Alternatively, you can use the remote_system object to get this information.",
      behaviour: :init_only,
    },
    scheduled_timestamp:          { 
      type:      "Optional[String]",
      desc:      "Date and time at which the import session is scheduled to start. The date time is specified in ISO 8601 format with the time expressed in UTC format.",
    },
    source_resource_id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the volume or consistency group to be imported. Refer to the following objects for more information: * Storage Center : import_storage_center_volume, import_storage_center_consistency_group * VNX : import_vnx_volume, import_vnx_consistency_group * PS Series : import_psgroup_volume * Unity : import_unity_volume, import_unity_consistency_group",
      behaviour: :init_only,
    },
    state:          { 
      type:      "Optional[Enum['Scheduled','Paused','Queued','In_Progress','Mirror_Enabled','Ready_To_Start_Copy','Copy_In_Progress','Ready_For_Cutover','Cutover_In_Progress','Import_Completed','Cancelled','Failed','Cancel_Failed','Cancel_In_Progress','Cleanup_In_Progress','Cleanup_Failed','Invalid','Cleanup_Required','Import_Completed_With_Errors','Import_Cutover_Incomplete']]",
      desc:      "Import session states* Scheduled : Indicates that a user scheduled the import to run at a later time. The import remains in this state and waits until the schedule expires.* Paused : Indicates that the data copy between the source and destination volumes is paused.* Queued : Indicates that all imports are queued and run in a First In First Out (FIFO) order. This occurs when there are more active import sessions than supported.* In_Progress : Indicates that a queued import session is now in progress.* Mirror_Enabled : Indicates that an import session has completed setting up the entities required to import data from the source resource.* Ready_To_Start_Copy : Indicates that an import session is ready to start the data copy operation from the source resource.* Copy_In_Progress : Indicates that the data copy between the source and destination storage systems has started. The data copy runs as a background job and updates the import session percentage complete and estimated time left for the copy. Host IOs are pointed to PowerStore in this state. The import process keeps the source and destination volumes or consistency groups volume in sync by doing IO forwarding.* Ready_For_Cutover : Indicates that you can commit the import. The import process moves to this state after it successfully copies data from the source volume or consistency group.* Cutover_In_Progress : Indicates that the cutover of volumes that are part of a consistency group is in progress.* Import_Completed : Indicates that all operations completed successfully for a given import after a commit. In this state, the source volume is no longer mapped to the host and all stale paths are cleaned up.* Cancelled : Indicates that a user forcefully cancelled the import.* Failed : Indicates that there was an error during import. The appropriate error message  is returned in the error_response object.* Cancel_Failed : Indicates that an attempt to cancel the import of a volume failed in a consistency group import.* Cancel_In_Progress : Indicates that a cancel is in progress.* Cleanup_In_Progress : Indicates that the import of one or more volumes in a consistency group failed. When this occurs, you must roll back the import of the other volumes of the consistency group by executing a Cancel operation on each volume.* Cleanup_Failed : Indicates that there was an error while cleaning up the consistency group.* Invalid : Indicates that an import session is in an unexpected state.* Cleanup_Required : Indicates that there was an error while cleaning up the import or consistency group that requires user intervention to bring back host applications.* Import_Completed_With_Errors : Indicates that there was a mirror failure for one or more members while committing a consistency group due to which members were partially committed.The failed members were cancelled.* Import_Cutover_Incomplete : Indicates that one or more members  couldn't be committed successfully resulting in partial commit of the consistency group. Commit should be tried again on the consistency group.",
    },
    state_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to state",
    },
    volume_group_id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the volume group to which the imported volume will belong, if any.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
