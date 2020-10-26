plan powerstore::vcreate(
  TargetSpec $targets,
){
  apply($targets) {
    powerstore_volume { "small_volume":
     size => 1048576,
    }
  }
}
