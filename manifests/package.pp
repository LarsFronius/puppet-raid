class raid::package (
    $packages  = $raid::params::packages
    ) inherits raid::params
{
    package { $packages: }
}
