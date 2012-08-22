class raid::repo::debian {
  apt::source { 'raid':
    location    => 'http://hwraid.le-vert.net/debian',
    release     => $::lsbdistcodename,
    repos       => 'main',
  }
}
