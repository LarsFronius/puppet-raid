# Class: raid
#
# This module manages raid
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class raid {
    anchor {'raid::start': }->
    class {'raid::repo': }~>
    class {'raid::package': }~>
    class {'raid::service': }~>
    class {'raid::nagios': }~>
    anchor {'raid::end': }

}
