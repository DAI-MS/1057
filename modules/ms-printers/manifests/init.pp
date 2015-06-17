# Class: printers
#
# This module manages ils-printers 
#
# Parameters: instance number 1 - 10
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#  
#    class {'printers':
#              instance => $instance,
#    }
#

define printers_hash($queue, $uri, $location, $description) {
     printer { $queue:
       ensure      => present,
       uri         => $uri,
       location    => $location,
       description => $description,
       enabled     => true,
   }
}

class printers ($instance) {
  
  case $instance {
    /^(1|2|3|4|5|6|7|8|9|10)$/: {
      # Do nothing.
    }
    default: {
      fail("${title}: Ensure value '${instance}' is not supported should be range 1 - 10")
    }
    }

  $printers = hiera($instance)
  create_resources( printers_hash, $printers )
}
